class SecretCodeHolder
	def initialize(secret_code:nil)
		@secret_code = String.new secret_code
	end

	def get_clue_based_on(guess:guess)
		clue = ""
		already_inspectioned = Array.new(@secret_code.size) {
									false
								}
		guess.split("").each_index do |i|
			if guess[i] == @secret_code[i] and not already_inspectioned[i]
				clue << "+"
				already_inspectioned[i] = true
			end
		end
		return clue
	end
end
