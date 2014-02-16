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
	it "inializes with string '-' and '+'" do
		s = ScorePlusMinus .new("++-")
		s.correct_position.should eq(2)
		s.wrong_position.should eq(1)
	end
end