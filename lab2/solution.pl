% Place your solution here
% 17. В семье Семеновых пять человек: муж, жена, их сын, 
% сестра мужа и отец жены. Все они работают. Один  инженер,
% другой  юрист, третий  слесарь, четвертый  экономист, пятый  учитель.
% Вот что еще известно о них. Юрист и учитель  не кровные родственники.
% Слесарь  хороший спортсмен. Он пошел по стопам экономиста и играет
% в футбол за сборную завода. Инженер старше жены своего брата, но моложе,
% чем учитель. Экономист старше, чем слесарь. Назовите профессии
% каждого члена семьи Семеновых. 

male("husband").
male("son").
male("father").
female("wife").
female("sister").

playFootball(X) :-
	male(X).

hasBrother("sister").

blood("son", "sister").
blood("son", "husband").
blood("son", "wife").
blood("son", "father").
blood("husband", "sister").
blood("wife", "father").

bloodRelative(X, Y) :-
	blood(X, Y); blood(Y, X).

older("father", "wife").
older("father", "son").
older("wife", "son").
older("husband", "son").
older("sister", "wife").

solve() :-
	permutation(["husband", "wife", "son", "sister", "father"], [Engineer, Lawyer, Locksmith, Economist, Teacher]),

	hasBrother(Engineer),
	not(bloodRelative(Lawyer, Teacher)),
	playFootball(Locksmith),
	playFootball(Economist),
	not(older(Engineer, Teacher)),
	older(Economist, Locksmith),

	write("Engineer is "), write(Engineer), nl,
	write("Lawyer is "), write(Lawyer), nl,
	write("Locksmith is "), write(Locksmith), nl,
	write("Economist is "), write(Economist), nl,
	write("Teacher is "), write(Teacher), nl.