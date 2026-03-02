class ContactsController < ApplicationController
  def create
    # In production, you would save to a database or send an email here.
    # For now, we just show a flash message.
    redirect_to root_path(anchor: "contact"), notice: "Thanks for reaching out! We'll get back to you within 24 hours."
  end
end

