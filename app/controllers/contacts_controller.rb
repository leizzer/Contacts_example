class ApplicationController < ActionController::Base
def invite_friends

@user = User.find(params[:id])

//Pass the params of user id, can be the current user id also.for eg, invite/invite_friends/1

//It does not have impact of fetching the contacts from gmail, yahoo or hotmail.
end

def import
@users = User.find(params[:id])
begin
@sites = {“gmail”  => Contacts::Gmail, “yahoo” => Contacts::Yahoo, “hotmail” => Contacts::Hotmail}
@contacts = @sites[params[:from]].new(params[:login], params[:password]).contacts
@users , @no_users = [], []
@contacts.each do |contact|
if u = User.find(:first , :conditions => “email = ‘#{contact[1]}’” )
@users << u
else
@no_users << {:name => contact[0] , :email => contact[1]}
end
end
respond_to do |format|
format.html {render :template => ‘invite/_contact_list’, :layout => false}
format.xml {render : xml => @contacts.to_xml}
end
end
end
end