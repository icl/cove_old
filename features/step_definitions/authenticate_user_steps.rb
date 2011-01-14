Given /^a regular_user exists$/ do
end

When /^the user enters the correct email and password$/ do
  visit("/login")
  fill_in("user_email", :with => "test@test.com")
  fill_in("user_password", :with => "myPassword")
  click_button("user_submit")
end

Then /^they should be successfully logged in to the system$/ do
  pending
end

# When /^the user enters an incorrect email or password$/ do
#   pending # express the regexp above with the code you wish you had
# end
# 
# Then /^the user should not be logged in and should be redirected back to the login form$/ do
#   pending # express the regexp above with the code you wish you had
# end
