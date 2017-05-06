mine(*, 1).
mine(X, 0) :- not(mine(X, 1)).

%%% Inner row

% Not even leftmost column
validRow([Firstabove, Firstrightabove | Abovetail], [Firstcenter, Firstright | Centertail], [Firstbelow, Firstrightbelow | Belowtail]) :-
    validRow(Firstcenter, Firstabove, Firstrightabove, Firstright, Firstbelow, Firstrightbelow, Abovetail, Centertail, Belowtail).

% Leftmost column
validRow(*, Above, Rightabove, Right, Below, Rightbelow,
    [Nextabove | Abovetail], [Nextcenter | Centertail], [Nextbelow | Belowtail]) :-
        validRow(Right, Above, Rightabove, Nextabove, *, Nextcenter, Below, Rightbelow, Nextbelow,
            Abovetail, Centertail, Belowtail).

validRow(Center, Above, Rightabove, Right, Below, Rightbelow,
    .(Nextabove, Abovetail), .(Nextcenter, Centertail), .(Nextbelow, Belowtail)) :-
        Center is A + B + C + D + E,
        mine(Above, A), mine(Rightabove, B),
        mine(Right, C),
        mine(Below, D), mine(Right, E),
        validRow(Right, Above, Rightabove, Nextabove, Center, Nextcenter, Below, Rightbelow, Nextbelow,
            Abovetail, Centertail, Belowtail).

% Inner column
validRow(*, _, Above, Rightabove, _, Right, _, Below, Rightbelow,
    .(Nextabove, Abovetail), .(Nextcenter, Centertail), .(Nextbelow, Belowtail)) :-
        validRow(Right, Above, Rightabove, Nextabove, *, Nextcenter, Below, Rightbelow, Nextbelow,
            Abovetail, Centertail, Belowtail).

validRow(Center, Leftabove, Above, Rightabove, Left, Right, Leftbelow, Below, Rightbelow,
    .(Nextabove, Abovetail), .(Nextcenter, Centertail), .(Nextbelow, Belowtail)) :-
        Center is A + B + C + D + E + F + G + H,
        mine(Leftabove, A), mine(Above, B), mine(Rightabove, C),
        mine(Left, D), mine(Right, E),
        mine(Leftbelow, F), mine(Below, G), mine(Rightbelow, H),
        validRow(Right, Above, Rightabove, Nextabove, Center, Nextcenter, Below, Rightbelow, Nextbelow,
            Abovetail, Centertail, Belowtail).

% Rightmost column
validRow(*, _, _, _, _, _, _, _, _, [], [], []).
validRow(Center, Leftabove, Above, Rightabove, Left, Right, Leftbelow, Below, Rightbelow,
    [], [], []) :-
        Center is A + B + C + D + E + F + G + H,
        mine(Leftabove, A), mine(Above, B), mine(Rightabove, C),
        mine(Left, D), mine(Right, E),
        mine(Leftbelow, F), mine(Below, G), mine(Rightbelow, H).


validSolution([A, B, C]) :- validRow(A, B, C).
