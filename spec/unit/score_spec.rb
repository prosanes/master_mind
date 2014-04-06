require './domain/score'

describe Score do
	it "represents how many pins are in the correct position" do
		s = Score.new(correct_position:1)
		s.correct_position.should eq(1)
	end

	it "represents how many pins are in the wrong position" do
		s = Score.new(wrong_position:1)
		s.wrong_position.should eq(1)
	end

	it "can be compared to another score" do
		s = Score.new(wrong_position:1, correct_position:2)
		s2 = Score.new(wrong_position:1, correct_position:2)
		expect(s == s2).to be_true
		expect(s != s2).to be_false

		s = Score.new(wrong_position:2, correct_position:2)
		s2 = Score.new(wrong_position:1, correct_position:2)
		expect(s != s2).to be_true
	end
end

describe ScorePlusMinus do
	it "initializes with string '-' and '+'" do
		s = ScorePlusMinus.new("++-")
		s.correct_position.should eq(2)
		s.wrong_position.should eq(1)
	end

	it "prints '+' and '-' correctly" do
		string = ScorePlusMinus.new("++--").to_s
		string.should eq "++--"

		string = ScorePlusMinus.new("+++-").to_s
		string.should eq "+++-"
	end

	it "converts a Score to a ScorePlusMinus" do
		s = Score.new(correct_position: 2, wrong_position: 2)
		ScorePlusMinus(s).class.should eq ScorePlusMinus
	end
end
