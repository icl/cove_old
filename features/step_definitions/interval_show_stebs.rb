When /^I visit the interval show page$/ do 
  @interval = Interval.first
  visit interval_url(@interval)
end
Then /^I should see the title of the interval$/ do
  page.should have_selector("#title")
  find_by_id("title").text.strip().should == "Place Holder Title"
end
