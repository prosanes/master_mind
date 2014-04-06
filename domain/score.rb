
class Score
	attr_reader :correct_position, :wrong_position
	def initialize(correct_position:0, wrong_position:0)
		@correct_position = correct_position
		@wrong_position = wrong_position
	end

	def ==(other)
		self.correct_position == other.correct_position and
				self.wrong_position == other.wrong_position
	end
end

class ScorePlusMinus < Score
	def initialize(string_representation)
		correct = 0
		wrong = 0
		string_representation.each_char do |c|
			correct += 1 if c == '+'
			wrong += 1 if c == '-'
		end
		super(correct_position:correct, wrong_position:wrong)
	end

	def ==(other)
		super.==(new(other))
	end

	def to_s
		string = ""
		@correct_position.times { string += "+" }
		@wrong_position.times { string += "-" }
		string
	end
end

def ScorePlusMinus(value)
	if value.class == Score
		string = ""
		value.correct_position.times { string += "+" }
		value.wrong_position.times { string += "-" }
		string
		ScorePlusMinus.new(string)
	else
		ScorePlusMinus.new(value)
	end
end
