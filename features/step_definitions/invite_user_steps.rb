Given /^a admin$/ do
  Factory(:admin_user)
end

When /^the admin logs in to the site$/ do
  visit("/login")
  fill_in("user_email", :with => "admin@test.com")
  fill_in("user_password", :with => "password")
  click_button("user_submit")
end

