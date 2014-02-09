class CodeBreaker
	attr_reader :last_guess
	attr_reader :made_correct_guess
	alias_method :made_correct_guess?, :made_correct_guess

	def initialize
		@last_guess = "AABB"
		@made_correct_guess = false
	end
end
