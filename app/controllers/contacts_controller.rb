class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    consumer = Contacts::Yahoo.new
    redirect_to consumer.authentication_url(contact_url(1))
    session[:consumer] = consumer.serialize
  end

  def show
    consumer = Contacts::Yahoo.deserialize(session[:consumer])
    if consumer.authorize(params)
      @contacts = consumer.contacts
    else
      # handle error
    end
  end

end
