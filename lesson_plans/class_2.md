# Generalizing Vectors


Let's review: what is a vector? It is the fundamental construct in R is a vector, which is a collection of values with the concept of order. "collections" is an abstraction that you will see time and time again as a programmer.

Oh, what are these different kind of vectors? Here are the types in R.

But here's the great thing about vectors -- instead of just having a concept of order in one dimension, they can have a concept of order in two dimensions! Now you have a matrix. And guess what: you could expand that to as many dimensions as you wanted, and the way we index into things just expands naturally.

But a matrix can only have data of one type, often in the real world were working with lots of different types of variables. How do we deal with that? Data frames! What's a data frame? It's just a collection of vectors that are the same length! And guess what? We can still index into them the same way we indexed into matrices, which was just an extension of how we index into vectors! See how we are taking these simple abstractions and putting them together to make things that are more complicated?