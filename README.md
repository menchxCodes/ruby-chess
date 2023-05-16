# Chess
My attempt at re-creating Chess in Ruby. This is a [Odin Project Assignment](https://www.theodinproject.com/lessons/ruby-ruby-final-project).

This was my biggest project yet. It was hard to actually do a project from scratch, with no directions. I created what I thought were elegant solutions, but only now at the end of the project I realize how much better it could be done.

My biggest weak point in this project is that I couldn't stop myself from creating methods to do just one thing. Also I think it was a mistake seperating classes for each piece between Black and White. IF I wanted to refactor, I'd take these two lessons into mind.

My other weakness was not creating the classes in such a way that it would be easy to write tests for them. Also chess is really boring (sorry chess fans!) and I really did not want to create different chess scenarios to test. I did what I could, and I tried to tackle it by letting the computer play against itself.

Game-rules-wise it lacks 3 things:
1) The game does not consider the king moving through "checked" squares when castling.
2) En Passant is not implemented.
3) Currently pawns that reach the end are automatically promoted to Queen, and you cannot choose other pieces (just because I'm lazy, and who doesn't love a queen)

In conclusion, it was a great learning project, and I've decided to move on to the next lessons, as chess or Ruby is not my end goal. I might use this project in the future as I learn more and see how well I can refactor it!