%load dataset
#include "dataB.lp".
%k: definir le nombre de gene a choisir
#const k = 3.

%1. select k genes
%Choix aléatoire de k gènes parmi l'ensemble des gènes
k{selgens(V):pert(E,V,S,C)}k.
%Obtenir des informations complètes sur le gène sélectionné : 
%E : index cellulaire, V : gène, S : expression du gène, C : classe
aff(E,V,S,C) :- selgens(V),pert(E,V,S,C).

%2.1. chercher des cells dans meme class et avec meme valeur sur k gene
% Les cellules I, J de la même classe ont la même valeur sur le gène V
egaleclass(I,J,V) :- aff(I,V,S1,C1),aff(J,V,S2,C2),C1 == C2,I<J, S1==S2.
% AffiniteClass(I,J) est vrai quand les cellules (I,J) ont la même valeur sur tous les k gènes 
affiniteClass(I,J) :- k = {egaleclass(I,J,_)},aff(I,_,_,_),aff(J,_,_,_).

%2.2. chercher des cells dans differente class et avec meme valeur sur k gene
% Les cellules de différentes classes ont la même valeur de I, J sur le gène V 
% et toutes les valeurs de I, J sur les k gènes sélectionnés ne sont pas nulles.
egale(I,J,V) :- aff(I,V,S1,C1),aff(J,V,S2,C2),C1 != C2, S1==S2,I < J,score(I,Q1),score(J,Q2).
% Affinite(I,J) est vrai lorsque les cellules (I,J) ont la même valeur sur tous les k gènes
% et la paire de cellules (I,J) apparaît au plus une fois dans relation affinite/2.
0{affinite(I,J)}1 :- k={egale(I,J,_)},aff(I,_,_,_),aff(J,_,_,_).

%2.3 Filtrage pour la redondance
% Les cellules ayant la même valeur sur k gènes dans la même classe ne peuvent pas être présentes simultanément dans affinite/2.
:- affinite(I1,_), affinite(I2,_), affiniteClass(I1,I2).
:- affinite(_,J1), affinite(_,J2), affiniteClass(J1,J2).

%2.4 Filtrage des cellules ayant des valeurs 0 sur tous les k gènes
score(E,Q) :- Q = #sum{S: aff(E,_,S,_)},aff(E,_,_,_).  % Q est la somme des valeurs de genne d'un cell
:- score(E,Q),Q=0.

%3.Maximiser le nombre de paires de cellules qui satisfont affinite/2.
#maximize {1,I:affinite(I,_)}.

%4. Show results
#show selgens/1.
#show affinite/2.
