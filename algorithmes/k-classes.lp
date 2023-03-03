% Les atomes sont de la forme : 
% atom(numéro cellule, stage, nom gène, expression gène)

% Fichier des atomes
#include "données/B_3_classes.lp".

% constante k
#const k = 3.

% les différentes classes et une référence
class(S):- atom(_,S,_,_).
nb_class(N) :- N = #count {S : class(S)}.
ref(early_TE).

% selectionne les k gènes 
k{selec_gene(G) : atom(_,_,G,_)}k.

match_gene(C1,C2,S,G) :- ref(R), atom(C1,R,G,E), atom(C2,S,G,E), selec_gene(G), S != R.
match_atom(C1,C2) :- match_gene(C1,C2,_,_).
match_stage(C1,C2,S) :- k == #count {G : match_gene(C1,C2,S,G)}, match_atom(C1,C2), class(S).
possible_match(C1) :- nb_class(N), N-1 == #count {S : match_stage(C1,_,S)}, match_atom(C1,_).

0{match(C)}1 :- possible_match(C).
mclasse(C1, C2) :- C1 < C2, match_stage(C1,C3,_), match_stage(C2,C3,_).
:- match(C2), mclasse(C1,C2).

% maximise les affinités
#maximize {1, C : match(C)}.

% renvoie les k gènes sélectionnés et le nombre d'affinité
#show selec_gene/1.
#show match/1.