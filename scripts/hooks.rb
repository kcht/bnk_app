require 'pry'

class SimpleBaseClass
  def self.inherited( new_subclass )
    puts "Hey #{new_subclass} is now a subclass of #{self}!"
  end
end

class ChildClass < SimpleBaseClass

end

module UsefulMethods
  module ClassMethods
    def a_class_method
    end
  end
  def self.included( host_class )
    host_class.extend( ClassMethods )
  end
  def an_instance_method
  end
# Rest of the module deleted...
end

class Host
  include UsefulMethods
end
