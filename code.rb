require "deep_clone"

class Code
	NUM_SLOTS = 4
	NUM_COLORS = 6

	@array_representation = Array.new(NUM_SLOTS)
	attr_accessor :array_representation

	def initialize(array_representation:[])
		raise_error_on_invalid_representation(array_representation)
		@array_representation = array_representation
	end

		def raise_error_on_invalid_representation(array)
			if array.size != NUM_SLOTS
				raise InvalidCodeRepresentation, 
					"#{array.size} pins were given, expected #{NUM_SLOTS}"
			end
			array.each do |pin|
				if pin <= 0 || pin >= 7
					raise InvalidCodeRepresentation
				end
			end
		end

	def each(&block)
		@array_representation.each(&block)
	end

	def each_index(&block)
		@array_representation.each_index(&block)
	end

	def [](i)
		@array_representation[i]
	end

	def delete_at(i)
		@array_representation.delete_at(i)
	end

	def give_score_compared_to(other_code)
		clue = ""
		clue, remaining_guess_letters, already_inspectioned = 
			get_in_correct_position_score(other_code)
		clue << get_in_wrong_position_score(remaining_guess_letters, already_inspectioned)
		return clue
	end

	private
		def get_in_correct_position_score(guess)
			already_inspectioned = Array.new(@array_representation.size) { false	}
			remaining_guess_letters = DeepClone.clone(guess)
			clue = ""

			guess.each_index do |i|
				if guess[i] == @array_representation[i]
					clue << "+"
					already_inspectioned[i] = true
					remaining_guess_letters.delete_at(i)
				end
			end

			return clue, remaining_guess_letters, already_inspectioned
		end

		def get_in_wrong_position_score(remaining_guess_letters, already_inspectioned)
			clue = ""
			remaining_guess_letters.each do |guess_char|
				@array_representation.each_index do |i|
					if guess_char == @array_representation[i] and not already_inspectioned[i]
						clue << "-"
						already_inspectioned[i] = true
						break
					end
				end
			end
			return clue
		end
end

class InvalidCodeRepresentation < Exception; end;

class CodeLetters < Code
	def initialize(letters)
		array_representation = Array.new()
		letters.each_char do |c|
			array_representation.push(c.ord - 'A'.ord + 1)
		end
		super(array_representation:array_representation)
	end
end
