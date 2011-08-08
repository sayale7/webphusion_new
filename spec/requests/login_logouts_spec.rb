require 'spec_helper'

describe "LoginLogouts" do
	
	it "registers" do
	  user = Factory(:user)  
	  visit register_path 
	  fill_in "user_email", :with => user.email
	  fill_in "user_password", :with => user.password
	  fill_in "user_password_confirmation", :with => user.password
	  click_button "Registrieren"
	  current_path.should eq(login_path)
	  page.should have_content("Account erfolgreich angelegt!")
	end
	
	
  it "logs in and logs out" do
   	user = Factory(:user)  
    visit login_path 
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Einloggen"
    current_path.should eq(root_path)
    page.should have_content("Erfolgreich eingeloggt!")
    click_link "logout"
    current_path.shoud eq(login_path)
	end

	
	
end
