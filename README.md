# Master Mind

Is a code-breaking game. More info in [Wikipedia](http://en.wikipedia.org/wiki/Mastermind_(board_game))

## Reason for implementing

This is my personal project to study [clean code](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/ref=sr_1_1?ie=UTF8&qid=1391955682&sr=8-1&keywords=clean+code), TDD and other software engineering best practices as SOLID principles.

It is based on the exercise proposed by Uncle Bob's screen cast in [Episode 9, Single Responsability Principle](http://cleancoders.com/codecast/clean-code-episode-9/show)

## Game explanations

### Secret Code Holder

A [SecretCodeHolder](secret_code.rb) is responsible for inventing a code with 4 letters and answering clues to the guesser.
For each letter that is in the correct position, the clue has a "+".
For each letter that is in the incorrect position, the clue has a "-".

#### Some examples
If the secret code is "AABB" and the guess is "BBAE", the clue is "---".
If the secret code is "ABCD" and the guess is "ACDB", the clue is "+---".

More examples should be easly readable in SecretCodeHolder [spec file](secret_code_holder.rb)

