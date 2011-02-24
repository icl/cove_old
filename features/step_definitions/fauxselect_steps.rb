require "selenium-webdriver"
When /^(?:|I )click the fauxselect "([^"]*)"$/ do |selector|
	page.driver.browser.execute_script %Q{ $("#{selector}").find(".fauxselect_button").trigger("openme"); }
end
When /^(?:|I )select "([^"]+)" from the fauxselect "([^"]*)"$/ do |selection, selector|
	page.driver.browser.execute_script %Q{ $("#{selector}").find(".fauxselect_button").trigger("openme"); }
	with_scope(selector) do
		click_link(selection)
	end
end
