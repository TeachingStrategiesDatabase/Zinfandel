class StaticController < ApplicationController

	def homepage
		@departmentList = Department.departmentsForSelect #Department.getDepartmentList()
		
		@subjectList = Subject.getSubjectList()
	end

end
