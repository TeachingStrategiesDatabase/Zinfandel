class Subject < ActiveRecord::Base

	def self.getSubjectList
		connection.select_all("SELECT name, id FROM subjects").rows
	end

	def self.insertKeyword(subjectName)
		connection.execute("INSERT INTO subjects(name) VAlUES (\'" + subjectName + "\')")
	end

end
