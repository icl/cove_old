When /^(?:|I )search for "([^"]*)" with the global search$/ do |search|
  fill_in("global_search", :with => search)
  click_button("global_search_submit")
end

Then /^(?:|I )should see (\d+) result(?:|s)$/ do |num|
  with_scope("#resultcount") do
    if page.respond_to? :should
      page.should have_content(num)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see a result with a session type of "([^"]*)"$/ do |sessiontype|
  with_scope(".results") do
    if page.respond_to? :should
      page.should have_content("Session Type: #{sessiontype}")
    else
      assert page.has_content?("Session Type: #{sessiontype}")
    end
  end
end
