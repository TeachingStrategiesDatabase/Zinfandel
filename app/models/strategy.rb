class Strategy < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true,
                    length: { minimum: 3 }
    #validates :subject.to_i>1,
                  
    #validates :department.to_i>1

    validates :body, presence: true,
                    length: { minimum: 10 }

	def self.search(dep,sub,kwd,ttle,aut,page)
		
		if dep && !dep.blank?
		#the user does not actually choose a department
			department = '%' + Department.find(dep).name + '%'
		else
			department = '%%'
		end

		if sub && !sub.blank?
		#the user does not actually choose a subject
			subject = '%' + Subject.find(sub).name + '%'
		else
			subject = '%%'
		end


		keywords = kwd.split(/(?:,|\s)+/)
		if keywords ==[]
			keywords = ['%%']
			sql_byKeyword = ''
			sql_order = ''
		else
			keywords.each do |k|
				k = '%' + k +'%'
			end
			sql_byKeyword = ", (SELECT strategy_id, COUNT(*) AS relevance FROM keywords WHERE keyword LIKE "
			keywords.each do |k|
				sql_byKeyword = sql_byKeyword + '\'' + k + '\' OR keyword LIKE'
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
		

		find_by_sql( ["SELECT * FROM strategies S, users U#{sql_byKeyword} WHERE #{sql_byKeyword.blank? ? '' : 'S.id = K.strategy_id AND '}S.user_id = U.id AND U.name LIKE ? AND S.title LIKE ? AND S.department LIKE ? AND S.subject LIKE ?#{sql_order} LIMIT ? OFFSET ?", author, title, department, subject, 2, (page.to_i-1)*2 ])
	end
end
