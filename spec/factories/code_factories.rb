Factory.define :code do |t|
  t.name "Test"
  t.description "This is just a test code"
  t.coding_type "phenomenon"
end

Factory.define :coding, :class => Coding do |t|
  t.name "Test"
  t.coding_type "phenomenon"
  t.user do
    if User.first
      User.first
    else
      Factory :regular_user
    end
  end
  t.interval do
    if Interval.first
      Interval.first
    else
      Factory :interval
    end
  end
end
