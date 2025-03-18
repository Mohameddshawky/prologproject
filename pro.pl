 % Database of matches
match(barcelona, real_madrid, 3, 2).
match(manchester_united, liverpool, 1, 1).
match(real_madrid, manchester_united, 2, 0).
match(liverpool, barcelona, 2, 2).
match(juventus, inter_milan, 1, 2).
match(bayern_munich, psg, 3, 1).
match(ajax, porto, 2, 1).
match(manchester_city, juventus, 2, 2).
match(liverpool, bayern_munich, 0, 3).
match(real_madrid, ajax, 4, 1).
goals(messi, 10).
goals(ronaldo, 12).
goals(pogba, 5).
goals(salah, 11).
goals(modric, 4).
goals(alisson, 0).
goals(dybala, 8).
goals(lewandowski, 9).
goals(neymar, 7).
goals(van_dijk, 2).
goals(ben_yedder, 6).
goals(ronaldo_silva, 3).
goals(de_jong, 4).
goals(ruben_dias, 1).
goals(ter_stegen, 0).

member2(X, [X|_]).
member2(X, [_|Tail]) :-
    member2(X, Tail).


matches_of_team(Team, Matches) :-
    findMatchesOfTeam(Team, [], Matches).


findMatchesOfTeam(_, Matches, Matches).


findMatchesOfTeam(Team, Ans, Matches) :-
    match(Team, Opponent, G1, G2),
    \+ member2((Team, Opponent, G1,  G2), Ans),
    NewAns = [(Team, Opponent, G1, G2) | Ans],
    findMatchesOfTeam(Team, NewAns, Matches).


findMatchesOfTeam(Team, Ans, Matches) :-
    match(Opponent, Team, G1, G2),
    \+ member2((Opponent, Team, G1, G2), Ans),
    NewAns = [(Opponent, Team, G1,G2) | Ans],
    findMatchesOfTeam(Team, NewAns, Matches).


findMatchesOfTeam(Team, Ans, Matches) :-
    match(Op1, Op2, _, _),
    Op1 \= Team,
    Op2 \= Team,
    findMatchesOfTeam(Team, Ans, Matches).


getlength([], 0).
getlength([_|Tail], Len) :-
    getlength(Tail, TmpN),
    Len is TmpN + 1.


num_matches_of_team(Team, N) :-
    matches_of_team(Team, L),
    getlength(L, N).

top_scorer(Player) :-
    goals(Player, Mxgoals),
    \+ (goals(_, Goal), Goal > Mxgoals).
