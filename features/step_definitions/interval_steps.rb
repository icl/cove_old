Given /^I am the page for an interval$/ do
	interval = Factory(:interval)
	visit interval_path(interval.id)
end
