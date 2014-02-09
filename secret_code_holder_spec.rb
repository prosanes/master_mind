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

	context "answers '+'s correctely" do
		let(:sch) { SecretCodeHolder.new(secret_code: "ABCD") }

		it "answers 1 '+' if there is only 1 letter in the correct position" do
			clue = sch.get_clue_based_on(guess: "A___")
			expect(clue.scan("+").count).to eq(1)

			clue = sch.get_clue_based_on(guess: "_B__")
			expect(clue.scan("+").count).to eq(1)
		end

		it "answers 2 '+' if there are only 2 letters in the correct position" do
			clue = sch.get_clue_based_on(guess: "AB__")
			expect(clue.scan("+").count).to eq(2)

			clue = sch.get_clue_based_on(guess: "_BC_")
			expect(clue.scan("+").count).to eq(2)

			clue = sch.get_clue_based_on(guess: "A__D")
			expect(clue.scan("+").count).to eq(2)
		end

		it "answers 3 '+' if there are only 3 letters in the correct position" do
			clue = sch.get_clue_based_on(guess: "ABC_")
			expect(clue.scan("+").count).to eq(3)

			clue = sch.get_clue_based_on(guess: "_BCD")
			expect(clue.scan("+").count).to eq(3)

			clue = sch.get_clue_based_on(guess: "A_CD")
			expect(clue.scan("+").count).to eq(3)
		end
	end

	context "answers '-' correctly" do
		let(:sch) { SecretCodeHolder.new(secret_code: "ABCD") }

		it "answers 1 '-' if there is only one letter in the code but in the wrong position" do

		end
	end

end
