class Subject < ActiveRecord::Base

	def self.subjectsForSelect
		Subject.all.collect { |d| [d.name, d.id] }
	end

	def self.getSubjectList
		connection.select_all("SELECT name, id FROM subjects").rows
	end

	def self.insertSubject(subjectName)
		connection.execute("INSERT INTO subjects(name) VAlUES (\'" + subjectName + "\')")
	end
end
