require './domain/code'

describe Code do
	context "Code initialization" do
		it "can be created with an array representation" do
			Code.new(array_representation:[1,1,1,1])
		end

		it "raises error if wrong number of pins are given" do
			expect_to_raise_invalid_code_representation([1,1])
			expect_to_raise_invalid_code_representation([1,1,1,1,1])
		end

		it "raises error if unexpected colors are given" do
			expect_to_raise_invalid_code_representation([0,1,1,1])
			expect_to_raise_invalid_code_representation([7,1,1,1])
		end

		def expect_to_raise_invalid_code_representation(array)
			expect {
				Code.new(array_representation:[1,1,1,1,1])
			}.to raise_error(InvalidCodeRepresentation)
		end
	end
	
	context "Subclass" do
		describe CodeLetters do
			it "creates a code with a letter representation" do
				CodeLetters.new("ABCD")
			end
		end
	end


	it "gives a perfect score if codes are the same" do
		assert_score_when_comparing(code1:"AAAA", code2:"AAAA", expected_score:"++++")
	end

	it "gives an empty socre if codes are completely different" do
		assert_score_when_comparing(code1:"AAAA", code2:"BBBB", expected_score:"")
		assert_score_when_comparing(code1:"AAAA", code2:"CCCC", expected_score:"")
		assert_score_when_comparing(code1:"AAAA", code2:"DDDD", expected_score:"")
	end

	context "answers '+'s correctely" do
		before :each do
			Code.any_instance.stub(:raise_error_on_invalid_representation)
		end
	
		it "answers 1 '+' if there is only 1 letter in the correct position" do
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"A___",expected_amount:1)
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"_B__",expected_amount:1)
		end

		it "answers 2 '+' if there are only 2 letters in the correct position" do
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"AB__",expected_amount:2)
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"_BC_",expected_amount:2)
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"A__D",expected_amount:2)
		end

		it "answers 3 '+' if there are only 3 letters in the correct position" do
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"ABC_",expected_amount:3)
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"_BCD",expected_amount:3)
			assert_score_in_correct_position_when_comparing(code1:"ABCD",code2:"A_CD",expected_amount:3)
		end
	end

	context "answers '-' correctly" do
		before :each do
			Code.any_instance.stub(:raise_error_on_invalid_representation)
		end

		it "answers 1 '-' if there is only one letter in the code but in the wrong position" do
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"_A__",expected_amount:1)
		end

		it "answers 2 '-' if there are 2 letters in the code but in the wrong possition" do
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"_AB_",expected_amount:2)
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"_A_B",expected_amount:2)
		end

		it "answers 3 '-' if there are 3 letters in the code but in the wrong possition" do
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"_ABC",expected_amount:3)
		end

		it "answers 4 '-' if there are 4 letters in the code but in the wrong possition" do
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"DABC",expected_amount:4)
		end

		it "doesnt answer 2 '-' if there is two letters in the guess but only one in the secret code on the incorrect possition" do
			assert_score_in_wrong_position_when_comparing(code1:"ABCD",code2:"_AAA",expected_amount:1)
		end
	end

	context "answer '+'s and '-'s correctly" do
		it "code is ABCD guess is ACDB" do
			assert_score_when_comparing(code1:"ABCD",code2:"ACDB",expected_score:"+---")
		end

		it "code is ABCD guess is AAAA" do
			assert_score_when_comparing(code1:"ABCD",code2:"AAAA",expected_score:"+")
		end

		it "code is ABCD guess is BBBB" do
			assert_score_when_comparing(code1:"ABCD",code2:"BBBB",expected_score:"+")
		end

		it "code is AABB guess is BCDE" do
			assert_score_when_comparing(code1:"AABB",code2:"BCDE",expected_score:"-")
		end

		it "code is AABB guess is BBAC" do
			assert_score_when_comparing(code1:"AABB",code2:"BBAC",expected_score:"---")
		end
	end

	def assert_score_in_wrong_position_when_comparing(code1:"", code2:"", expected_amount:0)
		c1 = CodeLetters.new(code1)
		c2 = CodeLetters.new(code2)
		clue = c1.give_score_compared_to(c2)
		clue.wrong_position.should eq(expected_amount)
	end

	def assert_score_in_correct_position_when_comparing(code1:"", code2:"", expected_amount:0)
		c1 = CodeLetters.new(code1)
		c2 = CodeLetters.new(code2)
		clue = c1.give_score_compared_to(c2)
		clue.correct_position.should eq(expected_amount)
	end

	def assert_score_when_comparing(code1:"", code2:"", expected_score:"")
		c1 = CodeLetters.new(code1)
		c2 = CodeLetters.new(code2)
		clue = c1.give_score_compared_to(c2)
		s = ScorePlusMinus.new(expected_score)
		expect(clue).to eq(s)
	end

end
