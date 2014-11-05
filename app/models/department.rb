class Department < ActiveRecord::Base

	def self.getDepartmentList
		connection.select_all("SELECT name, id FROM departments").rows
	end

	def self.insertDepartment(departmentName)
		connection.execute("INSERT INTO departments(name) VAlUES (\'" + departmentName + "\')")
	end
end
