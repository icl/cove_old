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
