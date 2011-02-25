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

When /^(?:|I )filter by the camera angle "([^"]*)"$/ do |selection|
	page.driver.browser.execute_script %Q{ $(".camera_angle_selector").find(".fauxselect_button").trigger("openme"); }
	with_scope(".camera_angle_selector") do
		click_link(selection)
	end
end
When /^(?:|I )filter by the phrase type "([^"]*)"$/ do |selection|
	page.driver.browser.execute_script %Q{ $(".phrase_type_selector").find(".fauxselect_button").trigger("openme"); }
	with_scope(".phrase_type_selector") do
		click_link(selection)
	end
end
