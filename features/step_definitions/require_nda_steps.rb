Given /^a user who has not yet signed the NDA$/ do
  Factory(:first_time_user)
end
Given /^there is nobody loggedin$/ do
  visit("/logout")
end

When /^the user logs in to the site$/ do
  visit("/login")
  fill_in("user_email", :with => "first@time.com")
  fill_in("user_password", :with => "password")
  click_button("user_submit")
end

Then /^the user should redirected to a page for NDA authorization$/ do
  page.current_url.should == url_for(:controller => "nda", :action => "index")
end

Given /^a user is on the nda page/ do
  visit("/nda")
end

When /^the user accepts the nda and hits continue/ do
  check("accept")
  click_button("Continue")
end
