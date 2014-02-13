require './secret_code_holder'

describe SecretCodeHolder do

	it "gives clues based on guesses" do
		code = double(:give_score_compared_to => "++++")

		sch = SecretCodeHolder.new(secret_code:code)
		clue = sch.get_clue_based_on(guess:code)

		expect(clue).to eq("++++")
	end

end
