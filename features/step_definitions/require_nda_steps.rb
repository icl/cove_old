Given /^a user who has not yet signed the NDA$/ do
  Factory(:first_time_user)
end

When /^the user logs in to the site for the first time$/ do
  visit("/login")
  fill_in("user_email", :with => "first@time.com")
  fill_in("user_password", :with => "password")
  click_button("user_submit")
end