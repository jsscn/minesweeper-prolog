# Minesweeper puzzle in Prolog

Project for the course Programming Paradigms. The assignment can be found in assignment.pdf. Solution by Josse Coen.

A board is represented by a list of lists containing either


* * for a mine, or
* a number 0–8 indicating the number of mines in the neighbouring tiles.

Each sublist corresponds to a row in the board.

The main idea behind my implementation is a predicate `valid_board` which determines whether or not a board is valid. Thanks to the nature of Prolog, querying this predicate with an incomplete board will find all of the valid boards which satisfy the query.

`valid_board` uses the `grid_reduces` predicate. For each of the board tiles, it determines the neighbouring tiles. Each mine in a neighbouring tile subtracts 1 from a tile's number. Only if all of the numbers on the board reduce to zero, `grid_reduces` will be true.

## Usage

Install [SWI-Prolog](http://www.swi-prolog.org). Run the executable (`swipl`) and consult `minesweeper.pl`. From the directory containing minesweeper.pl:

```
?- consult(minesweeper).
```

Then run a query against the `minesweeper` predicate such as the example in the assignment, or one in `query.pl`.