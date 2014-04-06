class CodeBreaker
	attr_reader :current_guess

	def initialize(initial_guess:nil)
		@current_guess = DeepClone.clone(initial_guess)
	end

	def receive_clue_for_current_guess(clue)
		@current_guess.next!
	end

end
