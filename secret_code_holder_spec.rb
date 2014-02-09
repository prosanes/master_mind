require './secret_code_holder'

describe SecretCodeHolder do
  
	it "has a secret code" do
		sch = SecretCodeHolder.new(secret_code:"AAAA")
	end

	it "answers a winning clue if the guess is correct" do
		sch = SecretCodeHolder.new(secret_code:"AAAA")
		clue = sch.get_clue_based_on(guess: "AAAA")
		expect(clue).to eq("++++")
	end

	it "answers an empty clue if the guess is completely wrong" do
		sch = SecretCodeHolder.new(secret_code:"AAAA")

		clue = sch.get_clue_based_on(guess: "BBBB")
		expect(clue).to eq("")

		clue = sch.get_clue_based_on(guess: "CCCC")
		expect(clue).to eq("")

		clue = sch.get_clue_based_on(guess: "DDDD")
		expect(clue).to eq("")
	end

	it "answers one '+' if there is only one letter in the correct position" do
		sch = SecretCodeHolder.new(secret_code: "ABCD")

		clue = sch.get_clue_based_on(guess: "A___")
		expect(clue.scan("+").count).to eq(1)

		clue = sch.get_clue_based_on(guess: "_B__")
		expect(clue.scan("+").count).to eq(1)
	end

end
