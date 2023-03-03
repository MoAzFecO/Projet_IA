% Les atomes sont de la forme : 
% atom(numéro cellule, stage, nom gène, expression gène)

% Fichier des atomes
#include "données/B.lp".

% constante k
#const k = 3.

% selectionne les k gènes 
k{selec_gene(G) : atom(_,_,G,_)}k.

% aff_gene : 2 cellules C1, C2 de 2 classes différentes S1,S2 dont le gène G coïncide
aff_gene(C1,C2,G) :- selec_gene(G), atom(C1,S1,G,E), atom(C2,S2,G,E), S1 != S2, C1 < C2.
aff(C1,C2) :- aff_gene(C1,C2,_).

% toutes les affinités : 2 cellules C1,C2 de aff_gene dont les k gènes coïncident
all_affinite(C1,C2) :- k == #count {G : aff_gene(C1,C2,G)} , aff(C1,C2).

% celles qui nous intéressent
0{affinite(C1,C2)}1 :- all_affinite(C1,C2).

% Supprime les doublons
:- affinite(C1,C2), affinite(C1,C3), C2!=C3.
:- affinite(C1,C2), affinite(C3,C2), C1!=C3.

not affinite(C3,C2) :- all_affinite(C1,C2), all_affinite(C3,C2), C1 < C3.

% maximise les affinités
#maximize {1, C : affinite(C,_)}.

% renvoie les k gènes sélectionnés et le nombre d'affinité
#show selec_gene/1.
#show affinite/2.