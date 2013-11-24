module Voteable
	extend ActiveSupport::Concern

	included do
		# puts "I'm being included!"
		has_many :votes, as: :voteable
	end

	def total_votes
		up_votes - down_votes
	end

	def up_votes
		self.votes.where(vote: true).size
	end

	def down_votes
		self.votes.where(vote: false).size
	end

end