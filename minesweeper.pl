

mine(*).

allZeroRows([]).
allZeroRows([Head | Tail]) :- allZeroRow(Head), allZeroRows(Tail).

allZeroRow([]).
allZeroRow([0 | Tail]) :- allZeroRow(Tail).
allZeroRow([* | Tail]) :- allZeroRow(Tail).

minus_one(8, 7).
minus_one(7, 6).
minus_one(6, 5).
minus_one(5, 4).
minus_one(4, 3).
minus_one(3, 2).
minus_one(2, 1).
minus_one(1, 0).
minus_one(0, -1).
minus_one(-1, -2).
minus_one(-2, -3).
minus_one(-3, -4).
minus_one(-4, -5).
minus_one(-5, -6).
minus_one(-6, -7).
minus_one(-7, -8).

valid_number(8).
valid_number(7).
valid_number(6).
valid_number(5).
valid_number(4).
valid_number(3).
valid_number(2).
valid_number(1).
valid_number(0).
valid_number(-1).
valid_number(-2).
valid_number(-3).
valid_number(-4).
valid_number(-5).
valid_number(-6).
valid_number(-7).
valid_number(-8).

% first list is the row we are subtracting the numbers from; second list is
% the one we are referencing in order to adapt the first;
% third is the adapted list.


reduce(Number, *, NewNumber) :- minus_one(Number, NewNumber).
reduce(Whatever, Number, Whatever) :- valid_number(Number).
reduce(*, *, *).

reduceNumbersRow([], [_|_], []) :- !.
reduceNumbersRow(Remainder, [], Remainder) :- !.

reduceNumbersRow([Subtract | SubtractingTail], [Reference | ReferenceTail], [Reduced | ReducedTail]) :-
    reduce(Subtract, Reference, Reduced),
    reduceNumbersRow(SubtractingTail, ReferenceTail, ReducedTail).


% Initiate
reduce_grid([FirstRow, SecondRow | Tail]) :-
    reduce_grid(FirstRow, SecondRow, Tail).

% Last row
reduce_grid(PenultimateRow, ThisRow, []) :-
    reduceNumbersRow(ThisRow, PenultimateRow, X1),
    reduceNumbersRow(X1, [0 | PenultimateRow], X2),
    [_ | PenultimateRowTail] = PenultimateRow,
    reduceNumbersRow(X2, PenultimateRowTail, X3),
    reduceNumbersRow(X3, [0 | ThisRow], X4),
    [_ | ThisRowTail] = ThisRow,
    reduceNumbersRow(X4, ThisRowTail, ReducedHead),
    allZeroRow(ReducedHead).

% First row
reduce_grid(ThisRow, SecondRow, [NextRow | Tail]) :-
    reduceNumbersRow(ThisRow, SecondRow, X1),
    reduceNumbersRow(X1, [0 | SecondRow], X2),
    [_ | SecondRowTail] = SecondRow,
    reduceNumbersRow(X2, SecondRowTail, X3),
    reduceNumbersRow(X3, [0 | ThisRow], X4),
    [_ | ThisRowTail] = ThisRow,
    reduceNumbersRow(X4, ThisRowTail, ReducedHead),
    allZeroRow(ReducedHead),
    reduce_grid(ThisRow, SecondRow, NextRow, Tail).

% Inner row
reduce_grid(AboveRow, ThisRow, BelowRow, [NextRow | Tail]) :-
    reduceNumbersRow(ThisRow, AboveRow, X1),
    reduceNumbersRow(X1, [0 | AboveRow], X2),
    [_ | AboveRowTail] = AboveRow,
    reduceNumbersRow(X2, AboveRowTail, X3),
    reduceNumbersRow(X3, BelowRow, X4),
    reduceNumbersRow(X4, [0 | BelowRow], X5),
    [_ | BelowRowTail] = BelowRow,
    reduceNumbersRow(X5, BelowRowTail, X6),
    reduceNumbersRow(X6, [0 | ThisRow], X7),
    [_ | ThisRowTail] = ThisRow,
    reduceNumbersRow(X7, ThisRowTail, ReducedHead),
    allZeroRow(ReducedHead),
    reduce_grid(ThisRow, BelowRow, NextRow, Tail).


reduce_grid(AboveRow, ThisRow, BelowRow, []) :-
    reduceNumbersRow(ThisRow, AboveRow, X1),
    reduceNumbersRow(X1, [0 | AboveRow], X2),
    [_ | AboveRowTail] = AboveRow,
    reduceNumbersRow(X2, AboveRowTail, X3),
    reduceNumbersRow(X3, BelowRow, X4),
    reduceNumbersRow(X4, [0 | BelowRow], X5),
    [_ | BelowRowTail] = BelowRow,
    reduceNumbersRow(X5, BelowRowTail, X6),
    reduceNumbersRow(X6, [0 | ThisRow], X7),
    [_ | ThisRowTail] = ThisRow,
    reduceNumbersRow(X7, ThisRowTail, ReducedHead),
    allZeroRow(ReducedHead),
    reduce_grid(ThisRow, BelowRow, []).

valid_board(Board) :- reduce_grid(Board).

print_board([]).
print_board([Row | Rows]) :- print_row(Row), print_board(Rows).

print_row([]) :- nl.
print_row([Tile | Tiles]) :- write(Tile), write(" "), print_row(Tiles).

minesweeper(Query) :- valid_board(Query), print_board(Query).
