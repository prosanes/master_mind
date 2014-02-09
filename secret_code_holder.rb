class SecretCodeHolder
	def initialize(secret_code:nil)
		@secret_code = secret_code
	end

	def get_clue_based_on(guess:guess)
		if guess == @secret_code
			"++++"
		else
			""
		end
	end
end
