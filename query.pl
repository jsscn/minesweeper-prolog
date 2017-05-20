
%% Example from assignment
minesweeper([
    [_,_,2,_,3,_],
    [2,_,_,_,_,_],
    [_,_,2,4,_,3],
    [1,_,3,4,_,_],
    [_,_,_,_,_,3],
    [_,3,_,3,_,_]]).

minesweeper([
    [_,3,_,2,_],
    [_,_,_,3,_],
    [2,2,2,_,_],
    [_,_,2,2,_],
    [_,_,2,_,2],
    [1,_,2,2,_]]).

minesweeper([
    [1,1,1,0],
    [2,*,3,1],
    [3,*,_,_],
    [2,*,4,_],
    [1,1,2,_]]).

%% Some smaller boards (some with multiple solutions)
%% (primarily useful for testing)

minesweeper([
    [2,3,_],
    [*,_,*],
    [_,3,2]]).

minesweeper([
    [2,_],
    [_,2]]).

minesweeper([
    [_,_],
    [2,_]]).

minesweeper([
    [_,3],
    [_,_]]).

minesweeper([
    [_,_,_],
    [_,8,_],
    [_,_,_]]).

minesweeper([
    [*,*,*],
    [*,_,*],
    [*,*,*]]).

minesweeper([[1, _, 2, _, _, _]]).

minesweeper([[_]]).

minesweeper([[_,_]]).

minesweeper([
    [_],
    [_]]).


