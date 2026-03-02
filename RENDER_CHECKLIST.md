# Render.com Deployment Checklist

## Pre-Deployment

- [ ] Get your `RAILS_MASTER_KEY` from `config/master.key`
  ```bash
  cat config/master.key
  ```
  **Save this somewhere safe - you'll need it!**

- [ ] Commit all changes to git
  ```bash
  git add .
  git commit -m "Configure app for Render.com deployment"
  ```

- [ ] Push to GitHub
  ```bash
  git push origin main
  ```

## Render Setup (Blueprint Method - Recommended)

- [ ] Go to https://dashboard.render.com
- [ ] Click "New +" → "Blueprint"
- [ ] Connect your GitHub repository
- [ ] Render detects `render.yaml` automatically
- [ ] When prompted, paste your `RAILS_MASTER_KEY`
- [ ] Review the services (web + database)
- [ ] Click "Apply" to create resources
- [ ] Wait for deployment to complete (5-10 minutes)

## Post-Deployment Verification

- [ ] Check health endpoint: `https://your-app-name.onrender.com/up`
  - Should show "OK" with green checkmark

- [ ] Visit your app: `https://your-app-name.onrender.com`
  - Should load the homepage

- [ ] Check logs in Render Dashboard
  - Look for "Listening on http://0.0.0.0:3000"
  - Verify no errors

- [ ] Test the contact form (if applicable)

## Optional Configuration

- [ ] Set up custom domain (if you have one)
  - Go to web service → "Custom Domains"
  - Add domain and configure DNS
  - Update `APP_HOST` environment variable

- [ ] Enable auto-deploy
  - Go to web service → "Settings"
  - Enable "Auto-Deploy"

- [ ] Set up monitoring/alerts
  - Configure in Render Dashboard

## Troubleshooting

If deployment fails:

1. **Check build logs** in Render Dashboard
2. **Verify `RAILS_MASTER_KEY`** is correct
3. **Check database connection** - ensure DATABASE_URL is set
4. **Review application logs** for errors

Common issues:
- Missing `RAILS_MASTER_KEY` → Add it in Environment Variables
- Database connection errors → Verify database is linked
- Asset compilation fails → Check Dockerfile and build logs

## Cost Summary

**Free Tier:**
- Web Service: Free (spins down after 15 min inactivity)
- PostgreSQL: Free (limited storage)
- Total: $0/month

**Starter Tier:**
- Web Service: $7/month (always on)
- PostgreSQL: $7/month (daily backups)
- Total: $14/month

## Support Resources

- Full guide: See `RENDER_DEPLOYMENT.md`
- Changes made: See `DEPLOYMENT_CHANGES.md`
- Render Docs: https://render.com/docs
- Rails on Render: https://render.com/docs/deploy-rails

