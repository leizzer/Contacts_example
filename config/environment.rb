# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Contacts::Application.initialize!


config = YAML.load_file("#{Rails.root}/config/contacts.yml")
Contacts.configure(config[Rails.env])