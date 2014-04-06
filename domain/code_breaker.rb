class CodeBreaker
	attr_reader :current_guess

	def initialize(initial_guess:nil)
		@current_guess = DeepClone.clone(initial_guess)
	end

	def receive_score_for_current_guess(score)
		@current_guess.next!
	end

end
