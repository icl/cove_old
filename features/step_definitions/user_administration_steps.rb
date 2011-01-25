Then /^I should see a list of all users registered in the system$/ do
  page.should have_selector("#list_container table tr")
end