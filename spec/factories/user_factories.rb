Factory.define :regular_user, :class => User do |f|
  f.admin false
  f.email 'user@test.com'
  f.password  "myPassword"
  f.password_confirmation  "myPassword"
  f.nda_signed true
end

Factory.define :admin_user, :class => User do |f|
  f.admin true
  f.email "admin@test.com"
  f.password "password"
  f.password_confirmation "password"
  f.nda_signed true
end

Factory.define :first_time_user, :class => User do |f|
  f.admin false
  f.email "first@time.com"
  f.password "password"
  f.password_confirmation "password"
  f.nda_signed false
end