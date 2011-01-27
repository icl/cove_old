Given /^a regular_user exists$/ do
  Factory(:regular_user)
end

Given /^a regular_user is logged_in$/ do
  Factory(:regular_user)
  visit("/login")
  fill_in("user_email", :with => "user@test.com")
  fill_in("user_password", :with => "myPassword")
  click_button("user_submit")
end

When /^the user enters the correct email and password$/ do
  visit("/login")
  fill_in("user_email", :with => "user@test.com")
  fill_in("user_password", :with => "myPassword")
  click_button("user_submit")
end

When /^the user enters an incorrect email or password$/ do
  visit("/login")
  fill_in("user_email", :with => "bad@value.com")
  fill_in("user_password", :with => "foobar")
  click_button("user_submit")
end

Given /^there is nobody logged_in$/ do
  visit("/logout")
end