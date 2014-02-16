require_relative './code'

class SecretCodeHolder
	def initialize(secret_code:nil)
		@secret_code = secret_code
	end

	def get_clue_based_on(guess:guess)
		@secret_code.give_score_compared_to(guess)
	end

end
