require './domain/secret_code_holder'

describe SecretCodeHolder do

	it "gives scores based on guesses" do
		code = double(:give_score_compared_to => "++++")

		sch = SecretCodeHolder.new(secret_code:code)
		score = sch.get_score_based_on(guess:code)

		expect(score).to eq("++++")
	end

end
