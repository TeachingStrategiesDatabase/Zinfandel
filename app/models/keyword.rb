class Keyword < ActiveRecord::Base

	def self.getKeywordList
		connection.select_all("SELECT name, id FROM keywords").rows
	end

	def self.getKeywordsByStrategy(strategyId)
		connection.execute("SELECT keyword FROM keywords WHERE strategy_id=" + strategyId.to_s + ";")
	end

	def self.setKeywordsByStrategy(strategyId,newKeywords)
		sql_delete = "DELETE FROM keywords WHERE strategy_id = #{strategyId}"
		connection.execute(sql_delete)
		
		newKeywords.each do |k|
			sql_insert = "INSERT INTO keywords(strategy_id, keyword) VALUES(#{strategyId},'#{k}')"
			connection.execute(sql_insert)
		end

	end


end
