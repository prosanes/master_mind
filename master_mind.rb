Dir["./domain/*.rb"].each { |f| require f }

puts "Welcome to mastermind"
puts "Do you want to play as the secret code holder or as the code breaker?"
begin
	puts "Please input (h) for holder or (b) for breaker."
	p = gets.chomp
end until p == 'h' or p == 'b'

if p == 'h'
	codeBreaker = CodeBreaker.new(initial_guess:CodeLetters.new("AABB"))
	begin
		puts "Please input a four letter code between A..F"
		code = gets.chomp
		code = CodeLetters.new(code)
	rescue InvalidCodeRepresentation
		puts "Your code is invalid. Please try again."
		retry
	end

	score = Score.new
	while true do
		puts "The computer guess is #{codeBreaker.current_guess.to_s}"
		puts "Please give it the score."
		puts "+ is for a letter in the write place."
		puts "- is for a letter in the code, but in the wrong place." 
		score_input = gets.chomp
		score = ScorePlusMinus.new(score_input)

		if score.correct_position != Code::NUM_PEGS
			codeBreaker.receive_clue_for_current_guess(clue:score)
		else
			break
		end
	end

	puts "The code was found: #{codeBreaker.current_guess.to_s}"
elsif p == 'b'
	computer = SecretCodeHolder.new(secret_code:CodeLetters.new("AABB"))
end
