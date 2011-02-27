Given /^(?:|I )am a regular user$/ do
	Factory(:regular_user)
end

Given /^(?:|I )am a regular user who is logged in$/ do
	Factory(:regular_user)
	visit("/login")
	fill_in("user_email", :with => "user@test.com")
	fill_in("user_password", :with => "myPassword")
	click_button("user_submit")
end

Given /^(?:|I )am an admin user who is logged in$/ do
	Factory(:admin_user)
	visit("/login")
	fill_in("user_email", :with => "admin@test.com")
	fill_in("user_password", :with => "password")
	click_button("user_submit")
end

When /^(?:|I )enter the correct email and password$/ do
	visit("/login")
	fill_in("user_email", :with => "user@test.com")
	fill_in("user_password", :with => "myPassword")
	click_button("user_submit")
end

When /^(?:|I )enter an incorrect email or password$/ do
	visit("/login")
	fill_in("user_email", :with => "bad@value.com")
	fill_in("user_password", :with => "foobar")
	click_button("user_submit")
end

Given /^there is nobody logged in$/ do
	visit("/logout")
end
