# Deploying to Render.com

This guide will help you deploy your AgentForce Rails application to Render.com.

## Prerequisites

1. A Render.com account (sign up at https://render.com)
2. Your code pushed to a GitHub repository
3. Your `RAILS_MASTER_KEY` from `config/master.key`

## Deployment Steps

### Option 1: Deploy Using Blueprint (Recommended)

1. **Push your code to GitHub** (if not already done)

2. **Go to Render Dashboard**
   - Visit https://dashboard.render.com
   - Click "New +" → "Blueprint"

3. **Connect Repository**
   - Select your GitHub repository
   - Render will detect the `render.yaml` file

4. **Configure Environment Variables**
   - You'll be prompted to add `RAILS_MASTER_KEY`
   - Get the value from `config/master.key` in your local project
   - Paste it when prompted

5. **Review and Deploy**
   - Review the services (web service + PostgreSQL database)
   - Click "Apply" to create all resources
   - Render will automatically build and deploy your app

### Option 2: Manual Deployment

1. **Create PostgreSQL Database**
   - In Render Dashboard, click "New +" → "PostgreSQL"
   - Name: `agentforce-db`
   - Database: `agentforce_production`
   - Choose your plan (Free or Starter)
   - Click "Create Database"

2. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name**: `agentforce`
     - **Region**: Choose closest to your users
     - **Branch**: `main`
     - **Runtime**: Docker
     - **Plan**: Free or Starter

3. **Add Environment Variables**
   Go to Environment tab and add:
   - `RAILS_MASTER_KEY`: (from `config/master.key`)
   - `RAILS_ENV`: `production`
   - `SOLID_QUEUE_IN_PUMA`: `true`
   - `WEB_CONCURRENCY`: `2`
   - `DATABASE_URL`: (auto-populated when you link the database)

4. **Link Database**
   - In the web service settings, go to "Environment"
   - Click "Link Database"
   - Select the PostgreSQL database you created

5. **Deploy**
   - Click "Manual Deploy" → "Deploy latest commit"
   - Or enable "Auto-Deploy" for automatic deployments on git push

## Post-Deployment

### Verify Deployment

1. **Check Health Endpoint**
   - Visit: `https://your-app-name.onrender.com/up`
   - Should return "OK" with 200 status

2. **Check Logs**
   - In Render Dashboard, go to your web service
   - Click "Logs" tab to see application logs

3. **Run Database Migrations** (if needed)
   - The `release` command in Procfile runs `db:prepare` automatically
   - But you can manually run: `bin/rails db:migrate` from the Shell tab

### Update Your Domain

If you want to use a custom domain:
1. Go to your web service settings
2. Click "Custom Domains"
3. Add your domain and follow DNS instructions

Update the `APP_HOST` environment variable with your custom domain.

## Important Notes

- **Free Tier Limitations**: Free web services spin down after 15 minutes of inactivity
- **Database Backups**: Starter plan includes daily backups; Free plan does not
- **Logs**: Available for 7 days on Free plan, longer on paid plans
- **Build Time**: First deployment may take 5-10 minutes

## Troubleshooting

### Build Fails
- Check that `RAILS_MASTER_KEY` is set correctly
- Review build logs in Render Dashboard

### Database Connection Issues
- Verify `DATABASE_URL` is set (should be automatic when database is linked)
- Check that database and web service are in the same region

### Assets Not Loading
- Ensure `bin/rails assets:precompile` runs during build (it's in the Dockerfile)
- Check that `RAILS_ENV=production` is set

### Background Jobs Not Running
- Verify `SOLID_QUEUE_IN_PUMA=true` is set
- Check logs for Solid Queue supervisor startup messages

## Updating Your App

1. Push changes to GitHub
2. If auto-deploy is enabled, Render will automatically deploy
3. Otherwise, click "Manual Deploy" in Render Dashboard

## Cost Estimate

- **Free Tier**: $0/month (web service + database, with limitations)
- **Starter Tier**: ~$14/month ($7 web service + $7 database)
- **Professional**: Higher performance and features available

## Support

- Render Docs: https://render.com/docs
- Rails on Render Guide: https://render.com/docs/deploy-rails

