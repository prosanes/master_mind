class SecretCodeHolder
	def initialize(secret_code:nil)
		@secret_code = String.new secret_code
	end

	def get_clue_based_on(guess:guess)
		clue = ""
		clue, remaining_guess_letters, already_inspectioned = 
			answer_pluses(guess)
		clue << answer_misuses(remaining_guess_letters, already_inspectioned)
		return clue
	end

	private
	def answer_pluses(guess)
		already_inspectioned = Array.new(@secret_code.size) { false	}
		remaining_guess_letters = guess.split("")
		clue = ""

		guess.split("").each_index do |i|
			if guess[i] == @secret_code[i]
				clue << "+"
				already_inspectioned[i] = true
				remaining_guess_letters.delete_at(i)
			end
		end

		return clue, remaining_guess_letters, already_inspectioned
	end

	def answer_misuses(remaining_guess_letters, already_inspectioned)
		clue = ""
		remaining_guess_letters.each do |guess_char|
			@secret_code.split("").each_index do |i|
				if guess_char == @secret_code[i] and not already_inspectioned[i]
					clue << "-"
					already_inspectioned[i] = true
					break
				end
			end
		end
		return clue
	end
end
