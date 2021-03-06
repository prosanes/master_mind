require './domain/code_breaker'

describe CodeBreaker do
	it "inializes with a initial_guess" do
		cb = CodeBreaker.new(initial_guess:"AABB")
	end

	it "has a current guess" do
		cb = CodeBreaker.new(initial_guess:"AABB")
		expect(cb.current_guess).to eq("AABB")
	end

	it "accepts a score for the current guess" do
		cb = CodeBreaker.new(initial_guess:"AABB")
		cb.receive_score_for_current_guess("+++-")
	end

	it "makes a new guess based on informations given" do
		last_guess = "AAAA"
		cb = CodeBreaker.new(initial_guess:last_guess)
		(1..4).each do |i|
			cb.receive_score_for_current_guess(score:"")
			cb.current_guess.should_not eq(last_guess)
			last_guess = String.new cb.current_guess
		end
	end

end
