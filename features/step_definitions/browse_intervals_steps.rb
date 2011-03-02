Then /^(?:|I )should see a result with a session type of "([^"]*)"$/ do |session_type|
	with_scope(".interval_list") do
		if page.respond_to? :should
			page.should have_content(session_type)
		else
			assert page.has_content?(session_type)
		end
	end
end

Then /^(?:|I )should not see a result with a session type of "([^"]*)"$/ do |session_type|
	with_scope(".interval_list") do
		if page.respond_to? :should
			page.should have_no_content(session_type)
		else
			assert page.has_no_content?(session_type)
		end
	end
end

When /^(?:|I )filter by the camera angle "([^"]*)"$/ do |camera_angle|
	with_scope(".filter_camera_angle") do
		click_link(camera_angle)
	end
end

When /^(?:|I )filter by the phrase type "([^"]*)"$/ do |phrase_type|
	with_scope(".filter_phrase_type") do
		click_link(phrase_type)
	end
end

When /^(?:|I )filter by the start time "([^"]*)"$/ do |start_time|
	with_scope(".filter_start_time") do
		click_link(start_time)
	end
end
