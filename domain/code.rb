require "deep_clone"
require './domain/score'

class Code
	NUM_PEGS = 4
	NUM_PEG_STATES = 6

	@array_representation = Array.new(NUM_PEGS)
	attr_accessor :array_representation

	
	def initialize(array_representation:[], score_class:Score)
		raise_error_on_invalid_representation(array_representation)
		@array_representation = array_representation
		@score_class = score_class
	end

		private
		def raise_error_on_invalid_representation(array)
			if array.size != NUM_PEGS
				raise InvalidCodeRepresentation, 
					"#{array.size} pins were given, expected #{NUM_PEGS}"
			end
			array.each do |pin|
				if pin < 1 || pin > NUM_PEG_STATES
					raise InvalidCodeRepresentation
				end
			end
		end

	public
	def next!
		(NUM_PEGS-1).downto(0).each do |i|
			next_state = (@array_representation[i] + 1) % (NUM_PEG_STATES+1)
			@array_representation[i] = next_state
			if next_state == 0
				@array_representation[i] += 1
			else
				break
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
		correct, remaining_guess_letters, already_inspectioned = 
			get_in_correct_position_score(other_code)
		wrong = get_in_wrong_position_score(remaining_guess_letters, already_inspectioned)

		@score_class.new(correct_position:correct, wrong_position:wrong)
	end

	private
		def get_in_correct_position_score(guess)
			already_inspectioned = Array.new(@array_representation.size) { false	}
			remaining_guess_letters = DeepClone.clone(guess)
			n = 0

			guess.each_index do |i|
				if guess[i] == @array_representation[i]
					n += 1
					already_inspectioned[i] = true
					remaining_guess_letters.delete_at(i)
				end
			end

			return n, remaining_guess_letters, already_inspectioned
		end

		def get_in_wrong_position_score(remaining_guess_letters, already_inspectioned)
			n = 0
			remaining_guess_letters.each do |guess_char|
				@array_representation.each_index do |i|
					if guess_char == @array_representation[i] and not already_inspectioned[i]
						n += 1
						already_inspectioned[i] = true
						break
					end
				end
			end
			return n
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
