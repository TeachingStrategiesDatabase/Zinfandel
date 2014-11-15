class Strategy < ActiveRecord::Base
	belongs_to :user

	has_many :keywords

	validates :title, presence: true,
                    length: { minimum: 3 }
    #validates :subject.to_i>1,
                  
    #validates :department.to_i>1

    validates :body, presence: true,
                    length: { minimum: 10 }

	def keywords
		Keyword.where(:strategy_id => self.id)
	end
	
	def setKeywords(kwd)
		newKeywords = kwd.split(/(?:,|\s)+/)
		Keyword.setKeywordsByStrategy(self.id,newKeywords)
	end

	def self.search(dep, sub, kwd, ttle, aut, page, entries_per_page)
		
		if dep && !dep.empty?
		#the user does not actually choose a department
			department = dep.collect { |d| Department.find(d).name }
		else
			department = []
		end

		if sub && !sub.empty?
		#the user does not actually choose a subject
			subject = sub.collect { |s| Subject.find(s).name }
		else
			subject = []
		end


		keywords = kwd.split(/(?:,|\s)+/) if kwd
		if keywords.nil? || keywords ==[]
			keywords = ['%%']
			sql_byKeyword = ''
			sql_order = ''
		else

			sql_byKeyword = ", (SELECT strategy_id, COUNT(*) AS relevance FROM keywords WHERE keyword LIKE "
			keywords.each do |k|
				sql_byKeyword = sql_byKeyword + '\'%' + k + '%\' OR keyword LIKE'
			end

#the length of string ' OR keyword LIKE' is 15
			sql_byKeyword = sql_byKeyword.slice(0,sql_byKeyword.length-15)
			sql_byKeyword = sql_byKeyword + ' GROUP BY strategy_id) AS K'
			sql_order = ' ORDER BY K.relevance DESC'
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
		


		query = ["SELECT S.* FROM strategies S, users U#{sql_byKeyword} " + 
		         "WHERE #{sql_byKeyword.blank? ? '' : 'S.id = K.strategy_id AND '}S.user_id = U.id " + 
		         "AND U.name LIKE ? AND S.title LIKE ? " + 
		         "#{department.empty? ? '' : 'AND S.department IN (?) '}" + 
		         "#{subject.empty? ? '' : 'AND S.subject IN (?)'}" + 
		         "#{sql_order} LIMIT ? OFFSET ?"]
		query += [author]
		query += [title]
		query += [department] unless department.empty?
		query += [subject] unless subject.empty?
		query += [entries_per_page]
		query += [(page.to_i-1) * entries_per_page]
		
		find_by_sql(query)

	end
end
