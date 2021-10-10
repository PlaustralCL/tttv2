# Tic Tac Toe - 2.0
## Description
The primary purpose of developing this game was to practice test driven
development (TDD) as part of [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/connect-four). The
original assignment was to write tests for the tic tac toe game we [developed
previously](https://github.com/PlaustralCL/tic_tac_toe). However, I wasn't happy
with out the previus version came out and rather than trying to refactor the code
to get tests to work, I started from scratch.

Version 2.0 of the game is a complete rewrite. Using the experience I have gained
since the first time attempting this I was able to make the code much cleaner.
One significant difference that made coding this easier was modeling the board
as just a single array. The first time I made this I kepth everything in a 2d array,
which was much more difficult to work with.

[Live version of the game](https://replit.com/@PlaustralCL/tttv2#.replit)

[Repository](https://github.com/PlaustralCL/tttv2)

## Learning
I learned a lot about rspec during this project. Writing the tests before the
code was difficult at first, but I do feel it helped to keep me disciplined
the structure.  My project would benefit from more planning before I start
writing tests or codes to better document the requirements that should be tested
and to outline the structure of the program.

## Future Enhancements
If I have spare time in the future, here are possible enhancements to this program:
* Add an option to have a computer player. Ideally there could be two levels,
one for random moves and one that uses min-max to find the best move. This would
be good algorithm practice.
* Give users the option of entering their own names rather than defaulting to
Player 1 and Player 2.