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



nonempty([[_|_] | _]).
nonempty([[] | Rest]) :- nonempty(Rest).

empty([]).
empty([[] | Rest]) :- empty(Rest).


%% Return first element of each sublist
%% (and what remains from the original list)
first_column([], [], []).
first_column([[] | Rows], [[] | Remainder], Column) :-
    first_column(Rows, Remainder, Column).

first_column([[Element | Row] | Rows], [Row | Remainder], [Element | Column]) :-
    first_column(Rows, Remainder, Column).


%% Transpose a list of lists.
transpose(All, []) :- empty(All).
transpose(All, [NewRow | Result]) :-
    nonempty(All),
    first_column(All, YetToBeTransposed, NewRow),
    transpose(YetToBeTransposed, Result).



%% Tile reduces iff:
%% - it is a mine; or
%% - it's a number which the number of mines in neighbouring tiles
tile_reduces(*, _).
tile_reduces(0, []).
tile_reduces(Number, [* | Neighbours]) :-
    minus_one(Number, NewNumber),
    tile_reduces(NewNumber, Neighbours).

tile_reduces(Number, [NeighbourNumber | Neighbours]) :-
    valid_number(Number),
    valid_number(NeighbourNumber),
    tile_reduces(Number, Neighbours).



%% Row reduces iff all its tiles reduce
row_reduces([], _).
row_reduces([Tile | Row], [Neighbours | Others]) :-
    tile_reduces(Tile, Neighbours),
    row_reduces(Row, Others).



% Initiate /1
grid_reduces([FirstRow, SecondRow | Tail]) :-
    grid_reduces(FirstRow, SecondRow, Tail).

% Last row /3
grid_reduces(PenultimateRow, ThisRow, []) :-
    [_ | PenultimateRowTail] = PenultimateRow,
    [_ | ThisRowTail] = ThisRow,
    transpose([
        [0 | PenultimateRow], PenultimateRow, PenultimateRowTail,
        [0 | ThisRow], ThisRowTail],
            Neighbours),
    row_reduces(ThisRow, Neighbours).

% First row /3
grid_reduces(ThisRow, SecondRow, [NextRow | Tail]) :-
    grid_reduces(ThisRow, SecondRow, NextRow, Tail),
    [_ | SecondRowTail] = SecondRow,
    [_ | ThisRowTail] = ThisRow,
    transpose([
        SecondRow,
        [0 | SecondRow],
        SecondRowTail,
        [0 | ThisRow],
        ThisRowTail
    ], Neighbours),
    row_reduces(ThisRow, Neighbours).

% Inner row /4
grid_reduces(AboveRow, ThisRow, BelowRow, [NextRow | Tail]) :-
    grid_reduces(ThisRow, BelowRow, NextRow, Tail),
    [_ | AboveRowTail] = AboveRow,
    [_ | BelowRowTail] = BelowRow,
    [_ | ThisRowTail] = ThisRow,
    transpose([
        AboveRow, [0 | AboveRow], AboveRowTail,
        BelowRow, [0 | BelowRow], BelowRowTail,
        [0 | ThisRow], ThisRowTail
    ], Neighbours),
    row_reduces(ThisRow, Neighbours).

% Second to last row /4
grid_reduces(AboveRow, ThisRow, BelowRow, []) :-
    grid_reduces(ThisRow, BelowRow, []),
    [_ | AboveRowTail] = AboveRow,
    [_ | BelowRowTail] = BelowRow,
    [_ | ThisRowTail] = ThisRow,
    transpose([
        AboveRow, [0 | AboveRow], AboveRowTail,
        BelowRow, [0 | BelowRow], BelowRowTail,
        [0 | ThisRow], ThisRowTail
    ], Neighbours),
    row_reduces(ThisRow, Neighbours).

valid_board(Board) :- grid_reduces(Board).

print_board([]).
print_board([Row | Rows]) :- print_row(Row), print_board(Rows).

print_row([]) :- nl.
print_row([Tile | Tiles]) :- write(Tile), write(" "), print_row(Tiles).

minesweeper(Board) :- valid_board(Board), print_board(Board).
minesweeper(Board, _) :- minesweeper(Board).
