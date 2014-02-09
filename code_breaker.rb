class CodeBreaker
	attr_reader :current_guess
	attr_reader :made_correct_guess
	alias_method :made_correct_guess?, :made_correct_guess

	def initialize(initial_guess:"AABB")
		@current_guess = String.new(initial_guess)
		@made_correct_guess = false
	end

	def make_next_guess(clue:nil)
		if clue =="++++"
			@made_correct_guess = true 
		else 
			@made_correct_guess = false
			@current_guess << "A"
		end
	end

end
