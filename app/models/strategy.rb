class Strategy < ActiveRecord::Base
	belongs_to :user

	def self.search(dep,sub,kwd,ttle,aut,page)
		department = '%%'
		case dep
		when 1
			department = '%%'
		when 2
			department = '%Computer Science%'
		else
			department = '%%'
		end

		subject = '%%'
		case sub
		when 1
			subject = '%%'
		when 2
			subject = '%Computer Science%'
		else
			subject = '%%'
		end

		if not kwd
			keyword = '%%'
		else
			keyword = '%' + kwd + '%'
		end

		if not ttle
			title = '%%'
		else
			title = '%' + ttle + '%'
		end

		if not aut
			author = '%%'
		else
			author = '%' + aut + '%'
		end
		

		find_by_sql( ["SELECT * FROM strategies WHERE title LIKE ? LIMIT ? OFFSET ?",title, 2, (page.to_i-1)*2 ])
	end
end
