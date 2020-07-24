boat(1, 0).
boat(2, 0).
boat(3, 0).
boat(0, 1).
boat(0, 2).
boat(0, 3).
boat(1, 1).
boat(2, 1).

start(s(3,3, left, 0, 0)).
goal(s(_ ,_ ,_ , 3, 3)).

safely(M, K) :-
	M >= K; M =:= 0. 

move(s(ML1, KL1, left, MR1, KR1), s(ML2, KL2, right, MR2, KR2)) :-
	boat(M, K), ML1 >= M, KL1 >= K,
	ML2 is ML1 - M, KL2 is KL1 - K,
	safely(ML2, KL2),
	MR2 is MR1 + M, KR2 is KR1 + K,
	safely(MR2, KR2).
move(s(ML1, KL1, right, MR1, KR1), s(ML2, KL2, left, MR2, KR2)) :-
	move(s(MR1, KR1, left, ML1, KL1), s(MR2, KR2, right, ML2, KL2)).

prolong([X | T], [Y, X | T]) :-
	move(X, Y),
	not(member(Y, [X | T])).

search_dpth :-
	write('DEPTH START'), nl,
	get_time(DEPTH),
	start(S),
	dpth([S], L),
	reverse(L, P),
	write(P), nl,
	get_time(DEPTH1),
	write('DEPTH END'), nl,
	T is DEPTH1 - DEPTH,
	write('TIME IS '), write(T), nl, 
	length(P, Length), 
	write('Length of path is '), write(Length), nl, nl.

dpth([X | T], [X | T]) :-
	goal(X).
dpth(P, L) :-
	prolong(P, P1),
	dpth(P1, L).

search_bdth :-
	write('BREADTH START'), nl,
	get_time(BREADTH),
	start(S),
	bdth([[S]], L),
	reverse(L, P),
	write(P), nl,
	get_time(BREADTH1),
	write('BREADTH END'), nl,
	T is BREADTH1 - BREADTH,
	write('TIME IS '), write(T), nl, 
	length(P, Length), 
	write('Length of path is '), write(Length), nl, nl.

bdth([[X | T] | _], [X | T]) :-
	goal(X).
bdth([P | Q1], R) :-
	findall(Z, prolong(P, Z), T),
	append(Q1, T, Q0), !,
	bdth(Q0, R).

int(1).
int(M) :-
	int(N), M is N + 1.

search_id :-
	write('ITER START'), nl,
	get_time(ITER),
	start(S),
	int(Level),
	dpth_id([S], L, Level),
	reverse(L, P),
	write(P), nl,
	get_time(ITER1),
	write('ITER END'), nl,
	T is ITER1 - ITER,
	write('TIME IS '), write(T), nl, 
	length(P, Length), 
	write('Length of path is '), write(Length), nl, nl.

dpth_id([X | T], [X | T], 0) :-
	goal(X).
dpth_id(P, L, N) :- N > 0,
	prolong(P, P1), N1 is N - 1,
	dpth_id(P1, L, N1).