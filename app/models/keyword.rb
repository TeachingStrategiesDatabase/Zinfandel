class Keyword < ActiveRecord::Base

	def self.getKeywordList
		connection.select_all("SELECT name, id FROM keywords").rows
	end

	def self.getKeywordsByStrategy(strategyId)
		connection.execute("SELECT keyword FROM keywords WHERE strategy_id=" + strategyId.to_s + ";")
	end


end
