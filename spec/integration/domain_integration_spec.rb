require './domain/code'
require './domain/code_breaker'
require './domain/secret_code_holder'

describe "Integration of Code, CodeBreaker, SecretCodeHolder" do
	it "works" do
		holder = SecretCodeHolder.new(secret_code:CodeLetters.new("ABCD"))
		breaker = CodeBreaker.new(initial_guess:CodeLetters.new("AABB"))

		found_correct_code = false
		(1..1025).each do
			clue = holder.get_clue_based_on(guess:breaker.current_guess)
			breaker.receive_clue_for_current_guess(clue:clue)
			if clue.correct_position == Code::NUM_PEGS
				found_correct_code = true
			end
		end

		expect(found_correct_code).to be_true
	end
end
