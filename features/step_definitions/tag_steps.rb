Given /^the tag "([^"]*)" exists$/ do |tag_name|
Factory(:tag, :name => tag_name)

end
