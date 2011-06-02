class ContactsController < ApplicationController
  
  def index
    if params[:oauth_token].present?
      consumer = Contacts::Yahoo.deserialize(session[:consumer])
      if consumer.authorize(params)
        @contacts = consumer.contacts
        respond_to do |wants|
          wants.html
        end
      end
    else
      redirect_to new_contact_url
    end
  end

  def new
    consumer = Contacts::Yahoo.new
    redirect_to consumer.authentication_url(contacts_url)
    session[:consumer] = consumer.serialize
  end


  private 

  def current_format
    request.format.to_s.split("/").last
  end
end
