require 'spec_helper'

describe "Registrations" do 

	it "no email" do
		visit register_path
    page.should have_content(I18n.t('user.register'))
    fill_in I18n.t('simple_form.labels.user.email'), :with => ''
    click_button 	I18n.t('user.register')
    current_path.should eq('/users')
    page.should have_content(I18n.t('mongoid.errors.models.user.attributes.email.blank'))
  end

	it "wrong email format" do
		visit register_path
    page.should have_content(I18n.t('user.register'))
    fill_in I18n.t('simple_form.labels.user.email'), :with => 'thomas.kohler'
    click_button 	I18n.t('user.register')
    current_path.should eq('/users')
    page.should have_content(I18n.t('mongoid.errors.models.user.attributes.email.invalid'))
  end
  
	it "no password" do
		visit register_path
    page.should have_content(I18n.t('user.register'))
    fill_in I18n.t('simple_form.labels.user.email'), :with => 'thomas.kohler@gmx.at'
    fill_in I18n.t('simple_form.labels.user.password'), :with => ''
    click_button 	I18n.t('user.register')
    current_path.should eq('/users')
    page.should have_content(I18n.t('mongoid.errors.models.user.attributes.password.blank'))
  end
  
	it "password not matches whith confirmation" do
		visit register_path
    page.should have_content(I18n.t('user.register'))
    fill_in I18n.t('simple_form.labels.user.email'), :with => 'thomas.kohler@gmx.at'
    fill_in I18n.t('simple_form.labels.user.password'), :with => 'asdf'
    fill_in I18n.t('simple_form.labels.user.password_confirmation'), :with => 'asd'
    click_button 	I18n.t('user.register')
    current_path.should eq('/users')
    page.should have_content(I18n.t('mongoid.errors.models.user.attributes.password.confirmation'))
  end
  
	it "registers correctly" do
		visit register_path
    page.should have_content(I18n.t('user.register'))
    fill_in I18n.t('simple_form.labels.user.email'), :with => 'thomas.kohler@gmx.at'
    fill_in I18n.t('simple_form.labels.user.password'), :with => 'asdf'
    fill_in I18n.t('simple_form.labels.user.password_confirmation'), :with => 'asdf'
    click_button 	I18n.t('user.register')
    current_path.should eq(login_path)
    page.should have_content(I18n.t('session.login'))
  end
	
end

# visit login_path
# user = Factory(:user)
# fill_in "email", :with => user.email
# fill_in "password", :with => '12345'
# click_button "Einloggen"
# current_path.should eq("/sessions")
# page.should have_content("Falsche Email oder Passwort!")
