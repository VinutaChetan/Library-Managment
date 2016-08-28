class ReportsController < ApplicationController
	def durationofbook
		@barrowingbooks=Barrowingbook.all
		@books=Book.all
	end	

	def beginning_of_week
  		Thread.current[:beginning_of_week] || beginning_of_week_default || :monday
	end

	def end_of_week
          days_to_sunday = self.wday!=0 ? 7-self.wday : 0
          result = self + days_to_sunday.days
          self.acts_like?(:time) ? result.end_of_day : result
     end
end
