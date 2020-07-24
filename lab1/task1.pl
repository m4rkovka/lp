/*Длина N списка List.
(List, N)*/
my_length([], 0).
my_length([_ | Tail], N) :-
	my_length(Tail, N1),
	N is N1 + 1.

/*Принадлежность элемента X списку List.
(X, List)*/
my_member(X, [X | _]).
my_member(X, [_ | Tail]) :-
	my_member(X, Tail).

/*Конкатенация списков List1 и List2. Результат List3.
(List1, List2, List3)*/
my_append([], List2, List2).
my_append([Head | Tail1], List2, [Head | Tail3]) :-
	my_append(Tail1, List2, Tail3).

/*Удаление элемента X из списка List. В результате
получается список List1.
(X, List, List1)*/
my_remove(X, [X | Tail], Tail).
my_remove(X, [Y | Tail], [Y | Tail1]) :-
	my_remove(X, Tail, Tail1).

/*Перестановка. List2 - перестановка списка List1.
(List1, List2)*/
my_permute([], []).
my_permute(List1, [X | P]) :-
	my_remove(X, List1, List_temp),
	my_permute(List_temp, P).

/*Список Sub является подсписком списка List.
(Sub, List)*/
my_sublist(Sub, List) :-
	my_append(_, L2, List),
	my_append(Sub, _, L2).

/*Подсчет числа вхождений N заданного элемента X
в список List (без стандартных предикатов).
(X, List, N)*/
count_entry(_,[],0).
count_entry(X,[X | Tail], N) :-
	count_entry(X, Tail , N1),
	N is N1 + 1, !.
count_entry(X, [_ | Tail], N) :-
	count_entry(X, Tail, N).
	
/*Подсчет числа вхождений N заданного элемента X
в список List.
(X, List, N)*/
std_count_entry(_, [], 0).
std_count_entry(X, List, N) :-
	my_remove(A, List, NEW),
	A = X,
	std_count_entry(X, NEW, N1),
	N is N1 + 1, !.
std_count_entry(X, List, N) :-
	my_remove(A, List, NEW),
	A \= X,
	std_count_entry(X, NEW, N).

/*Вычисление максимального элемента
(без стандартных предикатов).
(X, List)*/
max(X,[X | Tail]) :-
	maxhelp(X, Tail), !.
max(MAX, [_ | Tail]) :-
	max(MAX, Tail). 

/*Вычисление максимального элемента.
(X, List)*/
std_max(X, [X | Tail]) :- 
	maxhelp(X, Tail), !.
std_max(MAX, [X | Tail]) :-
	my_remove(X, [X | Tail], List),
	std_max(MAX, List).

/*Вспомогательный предикат 
для определения максимального элемента.*/
maxhelp(X,[H | Tail]) :-
	X >= H,
	maxhelp(X, Tail).
maxhelp(_, []).