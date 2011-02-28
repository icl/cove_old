Given /^there has been a tag applied to the interval$/ do
  @interval = Interval.first
  @interval.taggings << Factory(:tagging)
  @interval.save
end

Given /^There has been a phenomenon applied$/ do
  Factory(:code)
  @interval.codings << Factory(:coding)
  @interval.save
end
When /^I visit the interval show page$/ do 
  visit interval_url(@interval)
end
Then /^I should see the title of the interval$/ do
  page.should have_selector("#title")
  find_by_id("title").text.strip().should == "Place Holder Title"
end

Then /^I should see all the applied tags$/ do
  #save_and_open_page
  page.all("li.tag").length().should == 1  
end

Then /^I should see all the applied phenomenon$/ do
  page.all("#phenomenon_container li").length().should == 1
end

