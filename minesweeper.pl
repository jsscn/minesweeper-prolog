fully_reduced([]).
fully_reduced([0 | Tail]) :- fully_reduced(Tail).
fully_reduced([* | Tail]) :- fully_reduced(Tail).

minus_one(8, 7).
minus_one(7, 6).
minus_one(6, 5).
minus_one(5, 4).
minus_one(4, 3).
minus_one(3, 2).
minus_one(2, 1).
minus_one(1, 0).

valid_number(8).
valid_number(7).
valid_number(6).
valid_number(5).
valid_number(4).
valid_number(3).
valid_number(2).
valid_number(1).
valid_number(0).

% first list is the row we are subtracting the numbers from; second list is
% the one we are referencing in order to adapt the first;
% third is the adapted list.


reduce(Number, *, NewNumber) :- minus_one(Number, NewNumber).
reduce(Whatever, Number, Whatever) :- valid_number(Number).
reduce(*, *, *).

reduce_row([], [_|_], []) :- !.
reduce_row(Remainder, [], Remainder) :- !.

reduce_row([Subtract | SubtractingTail], [Reference | ReferenceTail], [Reduced | ReducedTail]) :-
    reduce(Subtract, Reference, Reduced),
    reduce_row(SubtractingTail, ReferenceTail, ReducedTail).


% Initiate /1
grid_reduces([FirstRow, SecondRow | Tail]) :-
    grid_reduces(FirstRow, SecondRow, Tail).

% Last row /3
grid_reduces(PenultimateRow, ThisRow, []) :-
    reduce_row(ThisRow, PenultimateRow, X1),
    reduce_row(X1, [0 | PenultimateRow], X2),
    [_ | PenultimateRowTail] = PenultimateRow,
    reduce_row(X2, PenultimateRowTail, X3),
    reduce_row(X3, [0 | ThisRow], X4),
    [_ | ThisRowTail] = ThisRow,
    reduce_row(X4, ThisRowTail, Reduced),
    fully_reduced(Reduced).

% First row /3
grid_reduces(ThisRow, SecondRow, [NextRow | Tail]) :-
    grid_reduces(ThisRow, SecondRow, NextRow, Tail),
    reduce_row(ThisRow, SecondRow, X1),
    reduce_row(X1, [0 | SecondRow], X2),
    [_ | SecondRowTail] = SecondRow,
    reduce_row(X2, SecondRowTail, X3),
    reduce_row(X3, [0 | ThisRow], X4),
    [_ | ThisRowTail] = ThisRow,
    reduce_row(X4, ThisRowTail, Reduced),
    fully_reduced(Reduced).

% Inner row /4
grid_reduces(AboveRow, ThisRow, BelowRow, [NextRow | Tail]) :-
    grid_reduces(ThisRow, BelowRow, NextRow, Tail),
    reduce_row(ThisRow, AboveRow, X1),
    reduce_row(X1, [0 | AboveRow], X2),
    [_ | AboveRowTail] = AboveRow,
    reduce_row(X2, AboveRowTail, X3),
    reduce_row(X3, BelowRow, X4),
    reduce_row(X4, [0 | BelowRow], X5),
    [_ | BelowRowTail] = BelowRow,
    reduce_row(X5, BelowRowTail, X6),
    reduce_row(X6, [0 | ThisRow], X7),
    [_ | ThisRowTail] = ThisRow,
    reduce_row(X7, ThisRowTail, Reduced),
    fully_reduced(Reduced).

% Second to last row /4
grid_reduces(AboveRow, ThisRow, BelowRow, []) :-
    grid_reduces(ThisRow, BelowRow, []),
    reduce_row(ThisRow, AboveRow, X1),
    reduce_row(X1, [0 | AboveRow], X2),
    [_ | AboveRowTail] = AboveRow,
    reduce_row(X2, AboveRowTail, X3),
    reduce_row(X3, BelowRow, X4),
    reduce_row(X4, [0 | BelowRow], X5),
    [_ | BelowRowTail] = BelowRow,
    reduce_row(X5, BelowRowTail, X6),
    reduce_row(X6, [0 | ThisRow], X7),
    [_ | ThisRowTail] = ThisRow,
    reduce_row(X7, ThisRowTail, Reduced),
    fully_reduced(Reduced).

valid_board(Board) :- grid_reduces(Board).

print_board([]).
print_board([Row | Rows]) :- print_row(Row), print_board(Rows).

print_row([]) :- nl.
print_row([Tile | Tiles]) :- write(Tile), write(" "), print_row(Tiles).

minesweeper(Board) :- valid_board(Board), print_board(Board).
minesweeper(Board, _) :- minesweeper(Board).