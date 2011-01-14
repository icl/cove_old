Factory.define :regular_user, :class => User do |f|
  f.email 'test@test.com'
  f.password  "myPassword"
  f.password_confirmation  "myPassword"
  f.admin  "false"
end