# Minesweeper puzzle in Prolog

Project for the course Programming Paradigms. The assignment can be found in assignment.pdf. Solution by Josse Coen.

A board is represented by a list of lists containing either

* a number 0–8 indicating the number of mines in the neighbouring tiles, or
* * for a mine.

Each sublist corresponds to a row in the board.

The main idea behind my implementation is a predicate `valid_board` which determines whether or not a board is valid. Thanks to Prolog's nature, querying this predicate with an incomplete board will find all of the valid boards which satisfy the query.

`valid_board` uses the `grid_reduces` predicate. For each of the board tiles, it counts all of the mines in the surrounding tiles by reducing the numbers on the board to zero. Only if all of the numbers on the board reduce to zero, `grid_reduces` will be true.

`grid_reduces` iterates over all the rows in the board and constructs a list of the neighbouring tiles of the tiles in each row. Then `row_reduces` verifies whether every tile in the row reduces.
