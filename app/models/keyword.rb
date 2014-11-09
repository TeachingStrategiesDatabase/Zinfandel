class Keyword < ActiveRecord::Base

	def self.getKeywordList
		connection.select_all("SELECT name, id FROM keywords").rows
	end

	def self.insertSubject(subjectName)
		connection.execute("INSERT INTO subjects(name) VAlUES (\'" + subjectName + "\')")
	end

end
