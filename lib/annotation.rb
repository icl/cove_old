module Annotatable
  
  module InstanceMethods
    def annotations
      @annotation ||= Annotation.new :user_id => self.id
    end
  end
  
  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end
