% Les atomes sont de la forme : 
% atom(numéro cellule, stage, nom gène, expression gène)

% Fichier des atomes
#include "données/.lp".

% constante k
#const k = 5.

% selectionne les k gènes 
k{selec_gene(G) : atom(_,_,G,_)}k.

% aff_gene : 2 cellules C1, C2 de 2 classes différentes S1,S2 dont le gène G coïncide
aff_gene(C1,C2,G) :- selec_gene(G), atom(C1,S1,G,E), atom(C2,S2,G,E), S1 != S2, C1 < C2.
aff(C1,C2) :- aff_gene(C1,C2,_).

% toutes les affinités : 2 cellules C1,C2 de aff_gene dont les k gènes coïncident
all_affinite(C1,C2) :- k == #count {G : aff_gene(C1,C2,G)} , aff(C1,C2).

% celles qui nous intéressent
0{affinite(C)}1 :- all_affinite(C,_).

meme_affinite(C1, C2) :- C1 < C2, all_affinite(C1, C3), all_affinite(C2, C3).
:- affinite(C2), meme_affinite(_,C2).

% maximise les affinités
#maximize {1, C : affinite(C)}.

% renvoie les k gènes sélectionnés et le nombre d'affinité
#show selec_gene/1.
#show affinite/1.