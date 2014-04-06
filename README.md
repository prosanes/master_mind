# Master Mind

Is a code-breaking game. More info in [Wikipedia](http://en.wikipedia.org/wiki/Mastermind_(board_game))

## Reason for implementing

This is my personal project to study [clean code](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/ref=sr_1_1?ie=UTF8&qid=1391955682&sr=8-1&keywords=clean+code), TDD and other software engineering best practices as SOLID principles.

It is based on the exercise proposed by Uncle Bob's screen cast in [Episode 9, Single Responsability Principle](http://cleancoders.com/codecast/clean-code-episode-9/show)

## Game explanations

### <a name="code"></a>Code

A [Code](domain/code.rb) is defined by disposed order of pegs, where each peg can have a different color (state).
The default configuration is 4 pegs and 6 colors.

A [Code](domain/code.rb) can be compared to each other and it gives a [Score](#score) for this comparison

### <a name="score"></a>Score

A [Score] represents how many pegs are in the same position for both codes.
And how many pegs are in both codes but in diferent positions

#### Some examples
Where '+' represents a peg in the same position, and '-' a peg in both codes but diferent positions:

* If the secret code is "AABB" and the guess is "BBAE", the score is "---".
* If the secret code is "ABCD" and the guess is "ACDB", the score is "+---".

More examples should be easly readable in Code [spec file](spec/unit/code_spec.rb)

### Secret Code Holder

A [SecretCodeHolder](domain/secret_code_holder.rb) is responsible for holding a code and answering scores to the guesser.

### Code Breaker

The [CodeBreaker](domain/code_breaker.rb) is responsible for breaking the code.

It starts with a guess, then receive a score for this current guess and makes a new guess.
