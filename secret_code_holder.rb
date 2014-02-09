class SecretCodeHolder
	def initialize(secret_code:nil)
		@secret_code = secret_code
	end

	def get_clue_based_on(guess:guess)
		clue = ""
		guess.split("").each_index do |i|
			if guess[i] == @secret_code[i]
				clue << "+"
			end
		end
		return clue
	end
end
