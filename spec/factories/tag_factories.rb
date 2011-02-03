Factory.define :tag, :class => Tag do |f|
  f.name "Test"
end

Factory.define :taging, :class => Taging do |f|
  f.user do
    if User.where(:email => "user@test.com").first
      User.where(:email => "user@test.com").first
    else
      Factory(:regular_user)
    end
  end
  f.association :interval, :factory => :interval
  f.association :tag, :factory => :tag
end