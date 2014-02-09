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
			clue = sch.get_clue_based_on(guess: "_A__")
			expect(clue.scan("-").count).to eq(1)
		end

		it "answers 2 '-' if there are 2 letters in the code but in the wrong possition" do
			clue = sch.get_clue_based_on(guess: "_AB_")
			expect(clue.scan("-").count).to eq(2)

			clue = sch.get_clue_based_on(guess: "_A_B")
			expect(clue.scan("-").count).to eq(2)
		end

		it "answers 3 '-' if there are 3 letters in the code but in the wrong possition" do
			clue = sch.get_clue_based_on(guess: "_ABC")
			expect(clue.scan("-").count).to eq(3)
		end

		it "answers 4 '-' if there are 4 letters in the code but in the wrong possition" do
			clue = sch.get_clue_based_on(guess: "DABC")
			expect(clue.scan("-").count).to eq(4)
		end

		it "doesnt answer 2 '-' if there is two letters in the guess but only one in the secret code on the incorrect possition" do
			clue = sch.get_clue_based_on(guess: "_AAA")
			expect(clue.scan("-").count).to eq(1)
		end
	end

	context "answer '+'s and '-'s correctly" do
		it "code is ABCD guess is ACDB" do
			sch = SecretCodeHolder.new(secret_code: "ABCD")
			clue = sch.get_clue_based_on(guess: "ACDB")
			expect(clue).to eq("+---")
		end

		it "code is ABCD guess is AAAA" do
			sch = SecretCodeHolder.new(secret_code: "ABCD")
			clue = sch.get_clue_based_on(guess: "AAAA")
			expect(clue).to eq("+")
		end

		it "code is ABCD guess is BBBB" do
			sch = SecretCodeHolder.new(secret_code: "ABCD")
			clue = sch.get_clue_based_on(guess: "BBBB")
			expect(clue).to eq("+")
		end

		it "code is AABB guess is BCDE" do
			sch = SecretCodeHolder.new(secret_code: "AABB")
			clue = sch.get_clue_based_on(guess: "BCDE")
			expect(clue).to eq("-")
		end

		it "code is AABB guess is BBAC" do
			sch = SecretCodeHolder.new(secret_code: "AABB")
			clue = sch.get_clue_based_on(guess: "BBAC")
			expect(clue).to eq("---")
		end
	end

end
