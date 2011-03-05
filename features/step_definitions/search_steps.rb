When /^(?:|I )search for "([^"]*)"$/ do |query|
	with_scope(".search_form") do
		fill_in("search_box", :with => query)
		click_button("Search")
	end
end
