class Department < ActiveRecord::Base

	def self.departmentsForSelect
		Department.all.collect { |d| [d.name, d.id] }
	end

	def self.getDepartmentList
		connection.select_all("SELECT name, id FROM departments").rows
	end

	def self.insertDepartment(departmentName)
		connection.execute("INSERT INTO departments(name) VAlUES (\'" + departmentName + "\')")
	end
end
