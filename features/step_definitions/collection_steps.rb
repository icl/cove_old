Given /^(?:|I )have a collection$/ do
  Factory(:collection)
  collection = Collection.find_by_name("Factory Collection")
  collection.user_id = User.find_by_email("user@test.com").id
  collection.save
end