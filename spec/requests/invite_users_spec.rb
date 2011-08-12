require 'spec_helper'

describe "InviteUsers" do 

	it "signs in" do	  
   	user = Factory(:user)  
    visit login_path 
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Einloggen"
    current_path.should eq(root_path)
    page.should have_content("Erfolgreich eingeloggt!")
  end
	
  it "invites guest" do
  	visit register_path
  	fill_in "user_email", :with => "guest@guest.com"
		fill_in "user_password", :with => "guest"
		fill_in "user_password_confirmation", :with => "guest"
		click_button "Registrieren"
	end
	
end
