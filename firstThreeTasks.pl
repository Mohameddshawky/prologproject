:-consult(league_data). 

%member
my_member(X, [X|_]).
my_member(X, [_|Tail]) :-
    my_member(X, Tail).
	
%append
my_append([], L2, L2).

my_append([H|T], L2, [H|Result]):-
	my_append(T, L2, Result).
	
%length
my_length([], 0).
my_length([_|Tail], Len) :-
    my_length(Tail, TempN),
    Len is TempN + 1.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TASK1 - Get a list of all players in a specific team 
players_in_team(Team, L):-
	playersInTeam(Team, [], L).
		
playersInTeam(Team, Ans, TempL):-
	player(Player, Team, _),
	\+ my_member(Player, Ans),
	!,
	my_append(Ans, [Player], NewAns), 
	playersInTeam(Team, NewAns, TempL).
	
playersInTeam(_, L, L).

	
	
%TASK2 - Count how many teams are from a specific country
teams_in_country(Country, L):-
	teamsInCountry(Country, [], L).
		
teamsInCountry(Country, Ans, TempL):-
	team(Name, Country, _),
	\+ my_member(Name, Ans),
	!,
	my_append(Ans, [Name], NewAns), 
	teamsInCountry(Country, NewAns, TempL).
	
teamsInCountry(_, L, L).
	
team_count_by_country(Country, N):-
	teams_in_country(Country, L),
	my_length(L, N).
	
%TASK3 - Find the team with the most championship titles 
most_successful_team(T):-
	team(T, _, MaxTitle),
    \+ (team(_, _, Title), Title > MaxTitle), !.
	
%TASK4 - List all matches where a specific team participated 
matches_of_team(Team, Matches) :-
    findMatchesOfTeam(Team, [], Matches).

findMatchesOfTeam(Team, Ans, TempMatches) :-
    match(Team, Opponent, G1, G2),
    \+ my_member((Team, Opponent, G1,  G2), Ans),
	!,
    NewAns = [(Team, Opponent, G1, G2) | Ans],
    findMatchesOfTeam(Team, NewAns, TempMatches).

findMatchesOfTeam(Team, Ans, TempMatches2) :-
    match(Opponent, Team, G1, G2),
    \+ my_member((Opponent, Team, G1, G2), Ans),
	!,
    NewAns = [(Opponent, Team, G1,G2) | Ans],
    findMatchesOfTeam(Team, NewAns, TempMatches2).

findMatchesOfTeam(_, Matches, Matches).

%TASK5 -  count all matches where a specific team participated
num_matches_of_team(Team, N) :-
    matches_of_team(Team, L),
    my_length(L, N).
	
%TASK6 -  Find the top goal scorer in the tournament 
top_scorer(Player) :-
    goals(Player, Mxgoals),
    \+ (goals(_, Goal), Goal > Mxgoals), !.