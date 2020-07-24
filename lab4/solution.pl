prist(Prist) --> 
	["в", "ы"],
	{Prist = ["в", "ы"]}.
prist(Prist) --> 
	["д", "о"],
	{Prist = ["д", "о"]}.
prist(Prist) --> 
	["з", "а"],
	{Prist = ["з", "а"]}.
prist(Prist) --> 
	["и", "з"],
	{Prist = ["и", "з"]}.
prist(Prist) --> 
	["н", "а"],
	{Prist = ["н", "а"]}.
prist(Prist) --> 
	["о", "б"],
	{Prist = ["о", "б"]}.
prist(Prist) --> 
	["о", "т"],
	{Prist = ["о", "т"]}.
prist(Prist) -->
	["п", "е", "р", "е"],
	{Prist = ["п", "е", "р", "е"]}.
prist(Prist) --> 
	["п", "о", "д"],
	{Prist = ["п", "о", "д"]}.
prist(Prist) --> 
	["п", "о"],
	{Prist = ["п", "о"]}.
prist(Prist) --> 
	["п", "р", "и"],
	{Prist = ["п", "р", "и"]}.
prist(Prist) --> 
	["п", "р", "о"],
	{Prist = ["п", "р", "о"]}.
prist(Prist) --> 
	["р","а", "з"],
	{Prist = ["р","а", "з"]}.
prist(Prist) --> 
	[],
	{Prist = []}.

kor(Kor) --> 
	["у", "ч"],
	{Kor = ["у", "ч"]}.
kor(Kor) --> 
	["м", "е", "р"],
	{Kor = ["м", "е", "р"]}.
kor(Kor) --> 
	["т", "о", "ч"],
	{Kor = ["т", "о", "ч"]}.

okon(Rod, Chislo) --> 
	["и", "л"],
	{Rod = ["муж"],
	Chislo = ["един"]}.

okon(Rod, Chislo) --> 
	["и", "л", "а"],
	{Rod = ["жен"],
	Chislo = ["един"]}. 

okon(Rod, Chislo) --> 
	["и", "л", "о"],
	{Rod = ["ср"],
	Chislo = ["-"]}. 

okon(Rod, Chislo) --> 
	["и", "л", "и"],
	{Rod = ["-"],
	Chislo = ["мн"]}. 

parse(X, Res) :- 
	alpha(Res, X, []).
alpha(Res) --> 
	prist(Prist), kor(Kor), 
	okon(Rod, Chislo),
	{Res = morf(prist(Prist), kor(Kor), rod(Rod), chislo(Chislo))}.