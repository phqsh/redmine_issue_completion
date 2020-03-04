module RedmineAutoPercent
  module IssuePatch
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      base.class_eval do
        before_save :update_percent
 		before_save :update_due_date
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def update_percent
      self.done_ratio = 100 if self.status.is_closed?
    end
 	def update_due_date
 	  if (self.status.is_closed?)
		self.due_date = Date.today
	  end
	end
  end
end
