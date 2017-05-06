

mine(*).

allZeroRows([]).
allZeroRows([Head | Tail]) :- allZeroRow(Head), allZeroRows(Tail).

allZeroRow([]).
allZeroRow([0 | Tail]) :- allZeroRow(Tail).
allZeroRow([* | Tail]) :- allZeroRow(Tail).

% first list is the row we are subtracting the numbers from; second list is
% the one we are referencing in order to adapt the first;
% third is the adapted list.

reduceNumbersRow([], _, []).
reduceNumbersRow(Remainder, [], Remainder).

% There is a mine; account for it in the reference list.
reduceNumbersRow([Number | SubtractingTail], [* | ReferenceTail], [NewNumber | Adapted]) :-
    reduceNumbersRow(SubtractingTail, ReferenceTail, Adapted),
    NewNumber == Number - 1.

% There is no mine; do not change subtracting list.
reduceNumbersRow([Unchanged | SubtractingTail], [Number | ReferenceTail], [Unchanged | Adapted]) :-
    not(mine(Number)),
    reduceNumbersRow(SubtractingTail, ReferenceTail, Adapted).

% Initiate
reduceNumbersGrid([FirstRow, SecondRow | Tail], Reduced) :-
    reduceNumbersGrid(FirstRow, SecondRow, Tail, Reduced).

% Last row
reduceNumbersGrid(PenultimateRow, ThisRow, [], [ReducedHead]) :-
    reduceNumbersRow(ThisRow, PenultimateRow, X1),
    reduceNumbersRow(X1, [0 | PenultimateRow], X2),
    [_ | PenultimateRowTail] = PenultimateRow,
    reduceNumbersRow(X2, PenultimateRowTail, X3),
    reduceNumbersRow(X3, [0 | ThisRow], X4),
    [_, ThisRowTail] = ThisRow,
    reduceNumbersRow(X4, ThisRowTail, ReducedHead).

% First row
reduceNumbersGrid(ThisRow, SecondRow, [NextRow | Tail], [ReducedHead | ReducedTail]) :-
    reduceNumbersRow(ThisRow, SecondRow, X1),
    reduceNumbersRow(X1, [0 | SecondRow], X2),
    [_ | SecondRowTail] = SecondRow,
    reduceNumbersRow(X2, SecondRowTail, X3),
    reduceNumbersRow(X3, [0 | ThisRow], X4),
    [_ | ThisRowTail] = ThisRow,
    reduceNumbersRow(X4, ThisRowTail, ReducedHead),
    reduceNumbersGrid(ThisRow, SecondRow, NextRow, Tail, ReducedTail).

% Inner row
reduceNumbersGrid(AboveRow, ThisRow, BelowRow, [NextRow | Tail], [ReducedHead | ReducedTail]) :-
    reduceNumbersRow(ThisRow, AboveRow, X1),
    reduceNumbersRow(X1, [0 | AboveRow], X2),
    [_, AboveRowTail] = AboveRow,
    reduceNumbersRow(X2, AboveRowTail, X3),
    reduceNumbersRow(X3, BelowRow, X4),
    reduceNumbersRow(X4, [0 | BelowRow], X5),
    [_, BelowRowTail] = BelowRow,
    reduceNumbersRow(X5, BelowRowTail, X6),
    reduceNumbersRow(X6, [0 | ThisRow], X7),
    [_, ThisRowTail] = ThisRow,
    reduceNumbersRow(X7, ThisRowTail, ReducedHead),
    reduceNumbersGrid(ThisRow, BelowRow, NextRow, Tail, ReducedTail).


reduceNumbersGrid(AboveRow, ThisRow, BelowRow, [], [ReducedHead | ReducedTail]) :-
    reduceNumbersRow(ThisRow, AboveRow, X1),
    reduceNumbersRow(X1, [0 | AboveRow], X2),
    [_, AboveRowTail] = AboveRow,
    reduceNumbersRow(X2, AboveRowTail, X3),
    reduceNumbersRow(X3, BelowRow, X4),
    reduceNumbersRow(X4, [0 | BelowRow], X5),
    [_, BelowRowTail] = BelowRow,
    reduceNumbersRow(X5, BelowRowTail, X6),
    reduceNumbersRow(X6, [0 | ThisRow], X7),
    [_, ThisRowTail] = ThisRow,
    reduceNumbersRow(X7, ThisRowTail, ReducedHead),
    reduceNumbersGrid(ThisRow, BelowRow, [], ReducedTail).

validBoard(Board) :- reduceNumbersGrid(Board, Reduced), allZeroRows(Reduced).

% minesweeper(Board, Reduced) :- validBoard(Board), Board = Result.
