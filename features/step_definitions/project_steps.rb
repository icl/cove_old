Given /^(?:|I )have no projects$/ do
  Project.find_all_by_user_id(User.find_by_email("user@test.com").id).each { |project| project.destroy }
end

Given /^(?:|I )have a project$/ do
  Factory(:project)
  project = Project.find_by_name("Factory Project")
  project.user_id = User.find_by_email("user@test.com").id
  project.save
end