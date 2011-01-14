Given /^a regular_user exists$/ do
  Factory(:regular_user)
end

When /^the user enters the correct email and password$/ do
  visit("/login")
  fill_in("user_email", :with => "user@test.com")
  fill_in("user_password", :with => "myPassword")
  click_button("user_submit")
end

Then /^they should be successfully logged in to the system$/ do
  page.should_not have_xpath("//div[contains(@class, 'flash')]")
  page.current_url.should == url_for(:controller => "nda", :action => "index")
  
end

When /^the user enters an incorrect email or password$/ do
  visit("/login")
  fill_in("user_email", :with => "bad@value.com")
  fill_in("user_password", :with => "foobar")
  click_button("user_submit")
end

Then /^the user should not be logged in and should be redirected back to the login form$/ do
  page.current_url.should == "http://www.example.com#{new_user_session_path}"
  page.find(:xpath, "//div[contains(@class, 'flash')]").text.should == "Invalid email or password."
  page.should have_xpath("//div[contains(@class, 'alert')]")
end
