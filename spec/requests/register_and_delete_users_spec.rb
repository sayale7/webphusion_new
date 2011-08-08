require 'spec_helper'

describe "RegisterAndDeleteUsers" do
  it "signs up" do
    visit register_path
		user = Factory(:user)
		fill_in "user_email", :with => user.email
		fill_in "user_password", :with => user.password
		fill_in "user_password_confirmation", :with => user.password
		click_button "Create User"
    current_path.should eq(root_path)
    page.should have_content("Sie haben sich erfolgreich angemeldet!")
  end

	it "logs in" do
    visit login_path
		user = Factory(:user)
		fill_in "email", :with => user.email
		fill_in "password", :with => user.password
		click_button "Einloggen"
    current_path.should eq(root_path)
    page.should have_content("Erfolgreich eingeloggt!")
  end

	it "logs in with wrong credentials" do
    visit login_path
		user = Factory(:user)
		fill_in "email", :with => user.email
		fill_in "password", :with => '12345'
		click_button "Einloggen"
    current_path.should eq(login_path)
    page.should have_content("Falsches Passwort oder Email!")
  end
end
