Volcano
=======

Problem description
-------------------

Given a generic 2D map with volcanos and cities, such as:

     ......*
     ..X....
     .......
     ....*..

Where X are the volcanos and * are the cities (or any representation without data loss). After one day, each volcano cloud destroy a neighbor space (but diagonals), so the map above after one day become like:

     ..X...*
     .XXX...
     ..X....
     ....*..

And so on, where the volcano cloud is interpreted as new volcanos. Find the number of days until all cities gets destroyed by a volcano.

---

References:

* https://gist.github.com/3759834
* https://gist.github.com/3752386
