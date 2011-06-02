class ContactsController < ApplicationController
  
  def index
    if params[:oauth_token].present?
      consumer = Contacts::Yahoo.deserialize(session[:consumer])
      if consumer.authorize(params)
        @contacts = consumer.contacts
        respond_to do |wants|
          wants.html
          #wants.json { render :json => @contacts }
        end
      end
    else
      redirect_to new_contact_url#(:format => current_format)
    end
  end

  def new
    consumer = Contacts::Yahoo.new
    redirect_to consumer.authentication_url(contacts_url)#:format => current_format
    session[:consumer] = consumer.serialize
  end


  private 

  def current_format
    request.format.to_s.split("/").last
  end
end
