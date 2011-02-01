class Interval < ActiveRecord::Base
  def annotations
    @annotations ||= Annotation.new :interval_id => self.id
  end
end
