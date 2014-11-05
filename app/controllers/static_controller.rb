class StaticController < ApplicationController

	def homepage
		@departmentList = Department.getDepartmentList()
		@subjectList = Subject.getSubjectList()
	end

end
