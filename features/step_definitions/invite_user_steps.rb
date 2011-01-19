Given /^a admin$/ do
  Factory(:admin_user)
end


When /^the admin logs in to the site$/ do
  visit("/login")
  fill_in("user_email", :with => "admin@test.com")
  fill_in("user_password", :with => "password")
  click_button("user_submit")
end


Given /^the admin is on the invitations page$/ do
  visit url_for(:controller => "invitations", :action => "new")
end

When /^they fill in the email address and submit$/ do
  fill_in("email", :with => "invite@devise.com")
  click_button("Invite User")
end

Then /^there should be a new user in the db$/ do
  User.where(:email => "invite@devise.com").lenght.should == 1
end

Then /^the user should receive an email$/ do
  pending # express the regexp above with the code you wish you had
end

