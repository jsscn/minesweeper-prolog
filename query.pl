
%% Example from assignment
minesweeper([[_,_,2,_,3,_],[2,_,_,_,_,_],[_,_,2,4,_,3],[1,_,3,4,_,_],[_,_,_,_,_,3],[_,3,_,3,_,_]]).

%% A simpler board with multiple solutions
minesweeper([[2,3,2],[*,*,*],[_,3,2]]).

%% 2x2 (niet ondersteund nu denk ik)
minesweeper([[_,_],[2,_]]).
minesweeper([[_, _, _], [*, *, *], [_, _, _]]).

%% https://codegolf.stackexchange.com/questions/102044/can-i-sweep-the-mines/102048#102048
minesweeper([[1,1,1,0],[2,*,3,1],[3,*,_,_],[2,*,4,_],[1,1,2,_]]).

%% ... add some more examples