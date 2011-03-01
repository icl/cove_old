Then /^(?:|I )should see the element "([^"]*)"$/ do |selector|
	if page.respond_to? :should
		page.should have_selector(selector)
	else
		assert page.has_selector?(selector)
	end
end

Then /^(?:|I )should not see the element "([^"]*)"$/ do |selector|
	if page.respond_to? :should
		page.should have_no_selector(selector)
	else
		assert page.has_no_selector?(selector)
	end
end

require "selenium-webdriver"
When /^(?:|I )look up the definition for "([^"]*)"$/ do |selector|
	page.driver.browser.execute_script %Q{ $("#{selector}").trigger("lookup"); }
end
