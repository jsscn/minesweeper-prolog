printReduce([[2, _, _], [*, *, *], [2, 3, 2]]).

minesweeper([[2, 3, 2], [_, _, _], [2, 3, 2]], X).
minesweeper([[1, 2, 1], [*, 2, *], [1, 2, 1]], X).

minesweeper([[2, 3, 2], [*, *, *], [2, 3, 2]], _).
number(X).

reduceNumbersRow([3, 2, 3], [*, *, *], X).

%% opgave
minesweeper([[_,_,2,_,3,_],[2,_,_,_,_,_],[_,_,2,4,_,3],[1,_,3,4,_,_],[_,_,_,_,_,3],[_,3,_,3,_,_]]).

%% opgave met iets meer ingevuld
minesweeper([[*,2,2,2,3,*],[2,_,_,_,_,_],[1,1,2,4,*,3],[1,2,3,4,*,2],[_,_,_,_,_,3],[_,3,_,3,_,_]]).

%% open plaatsen in vier laatste rijen
minesweeper([[*,2,2,2,3,*],[2,*,2,*,*,3],[_,_,2,4,_,3],[1,_,3,4,_,_],[_,_,_,_,_,3],[_,3,_,3,_,_]]).

%% open plaatsen in vijf laatste rijen
minesweeper([[*,2,2,2,3,*],[2,_,_,_,_,_],[_,_,2,4,_,3],[1,_,3,4,_,_],[_,_,_,_,_,3],[_,3,_,3,_,_]]).

%% opgave volledig
minesweeper([[*,2,2,2,3,*],[2,*,2,*,*,3],[1,1,2,4,*,3],[1,2,3,4,*,2],[2,*,*,*,4,3],[*,3,3,3,*,*]]).

%% opgave waar alleen bommen ingevuld moeten worden
minesweeper([[_,2,2,2,3,_],[2,_,2,_,_,3],[1,1,2,4,_,3],[1,2,3,4,_,2],[2,_,_,_,4,3],[_,3,3,3,_,_]]).

%% opgave zonder laatste kolom en rij
minesweeper([[*,2,2,2,2],[2,*,2,*,*],[1,1,2,4,*],[1,2,3,4,*],[1,*,*,*,2]]).
minesweeper([[_,_,2,_,2],[2,*,2,*,*],[1,1,2,4,*],[1,2,3,4,*],[1,*,*,*,2]]).
minesweeper([[_,_,2,_,2],[2,_,_,_,_],[1,1,2,4,*],[1,2,3,4,*],[1,*,*,*,2]]). % <2s
minesweeper([[_,_,2,_,2],[2,*,2,*,*],[_,_,2,4,_],[1,2,3,4,*],[1,*,*,*,2]]). % instant
minesweeper([[_,_,2,_,2],[2,*,2,*,*],[_,_,2,4,_],[1,2,3,4,*],[_,_,_,_,2]]). % instant
minesweeper([[_,_,2,_,2],[2,*,2,*,*],[_,_,2,4,_],[_,_,_,4,_],[_,_,_,_,2]]). % te lang

minesweeper([[2,3,2],[*,*,*],[_,3,2]]).

%% 2x2 (niet ondersteund nu denk ik)
minesweeper([[_,_],[2,_]]).
minesweeper([[_, _, _], [*, *, *], [_, _, _]]).

%% https://codegolf.stackexchange.com/questions/102044/can-i-sweep-the-mines/102048#102048
minesweeper([[1,1,1,0],[2,*,3,1],[3,*,_,_],[2,*,4,_],[1,1,2,_]]).
