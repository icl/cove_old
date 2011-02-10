Factory.define :tag, :class => Tag do |f|
  #f.description "No description."
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
  f.interval do
    if Interval.first
      Interval.first
    else
      Factory(:interval)
    end
  end
  f.tag do
    if Tag.first
      Tag.first
    else
      Factory(:tag)
    end
  end
end
