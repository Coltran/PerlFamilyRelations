% Coltran Hophan-Nichols
% CSCI 305 Lab 4
:- consult('royal.pl').

% Following are rules that define familial relationships

mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).

% The next two rules ensure that spouse works in either order
spouse(X,Y):- married(X,Y).
spouse(X,Y):- married(Y,X).

child(C,P):- parent(P,C).
son(S,P):- child(S,P), male(S).
daughter(D,P):- child(D,P), female(D).
sibling(X,Y):- mother(M,X), mother(M,Y), father(F,X), father(F,Y), X \= Y.
brother(X,Y):- sibling(X,Y), male(X).
sister(X,Y):- sibling(X,Y), female(X).

%uncles and aunts are siblings of our parents
uncle(U,N):- parent(P,N), sibling(U,P), male(U).
uncle(U,N):- parent(P,N), sibling(A,P), spouse(U,A), male(U).
aunt(A,N):- parent(P,N), sibling(A,P), female(A).
aunt(A,N):- parent(P,N), sibling(U,P), spouse(A,U), female(A).
grandparent(G,C):- parent(P,C), parent(G,P).
grandfather(G,C):- grandparent(G,C), male(G).
grandmother(G,C):- grandparent(G,C), female(G).
grandchild(C,G):- grandparent(G,C).

% ancestor is defined recursively either parent or parent of ancestor
ancestor(A,D):- parent(A,D).
ancestor(A,D):- parent(A,P), ancestor(P,D).
descendant(D,A):- ancestor(A,D).

% older equals born earlier
older(X,Y):- born(X, A), born(Y, B), A < B.
younger(X,Y):- older(Y,X).

% the regent is the one whos reign stared before birth and ended after
regentWhenBorn(X,Y):- born(Y,A), reigned(X,B,C), B < A, A < C.

% cousin is parents siblings child
cousin(X,Y):- parent(P,Y), sibling(S,P), child(X,S).
