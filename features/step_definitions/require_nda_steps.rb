Given /^a user who has not yet signed the NDA$/ do
  @user = Factory(:first_time_user)
  @user.save
end

When /^a new user attempts to access the site$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the user should redirected to a page for NDA authorization$/ do
  pending # express the regexp above with the code you wish you had
end
