When /^(?:|I )search for "([^"]*)" with the global search$/ do |search|
  fill_in("global_search", :with => search)
  click_button("global_search_submit")
end
