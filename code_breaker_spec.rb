require './code_breaker'

describe CodeBreaker do
	context "initialization" do
		let(:cb) { CodeBreaker.new }

		it "doesnt know if the initial guess is correct" do
			expect(cb.made_correct_guess?).to be_false
		end
	end

	it "knows it a correct guess if got the winning clue" do
		cb = CodeBreaker.new
		cb.make_next_guess(clue:"++++")
		expect(cb.made_correct_guess?).to be_true
	end

	it "tries another guess if the current_guess is not correct" do
		last_guess = "AAAA"
		cb = CodeBreaker.new(initial_guess:last_guess)
		(1..1024).each do |i|
			cb.make_next_guess(clue:"")
			cb.current_guess.should_not eq(last_guess)
			last_guess = String.new cb.current_guess
		end
	end
end
