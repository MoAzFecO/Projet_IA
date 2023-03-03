%% Anran et Li 02/03/2023

#include "données/anran_li/B.lp".
#const k = 3.

%1. select k genes
k{selgens(V):pert(E,V,S,C)}k.
aff(E,V,S,C) :- selgens(V),pert(E,V,S,C).

%2.1. chercher des cells dans different class et avec same expression sur k gene
egaleclass(I,J,V) :- aff(I,V,S1,C1),aff(J,V,S2,C2),C1 == C2,I<J, S1==S2.
affiniteClass(I,J) :- k = {egaleclass(I,J,_)},aff(I,_,_,_),aff(J,_,_,_).

%2.2. 
egale(I,J,V) :- aff(I,V,S1,C1),aff(J,V,S2,C2),C1 != C2, S1==S2,I < J,score(I,Q1),score(J,Q2).
0{affinite(I,J)}1 :- k={egale(I,J,_)},aff(I,_,_,_),aff(J,_,_,_).

%2.3
:- affinite(I1,_), affinite(I2,_), affiniteClass(I1,I2).
:- affinite(_,J1), affinite(_,J2), affiniteClass(J1,J2).

%2.4 score
score(E,Q) :- Q = #sum{S: aff(E,_,S,_)},aff(E,_,_,_).  % Q est la somme des valeurs de expression
:- score(E,Q),Q=0.

%3. maximize
#maximize {1,I:affinite(I,_)}.
#show selgens/1.
#show affinite/2.