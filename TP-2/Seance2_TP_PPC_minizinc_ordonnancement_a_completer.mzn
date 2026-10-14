% ============================================================================
% Optimisation pour l'IA — Séance 2 — TD-TP PPC, Exercice 6
% Ordonnancement ExedBike en MiniZinc — même instance qu'au TP2 (Exercice 4,
% CP-SAT/OR-Tools) : 3 lots sur une même ligne, non-chevauchement, minimiser
% le makespan. En MiniZinc, la contrainte globale de non-chevauchement
% d'intervalles est "disjunctive".
% ============================================================================

include "disjunctive.mzn";

int: horizon = 15;
array[1..3] of string: noms = ["Urban", "Cargo", "Sport"];
array[1..3] of int: dur = [3, 5, 4];  % durées en heures

array[1..3] of var 0..horizon: s;  % dates de début
array[1..3] of var 0..horizon: e;  % dates de fin

% --- ETAPE 1 : lier début, durée et fin (déjà écrit) ------------------------
constraint forall(i in 1..3)(e[i] = s[i] + dur[i]);

% --- ETAPE 2 : non-chevauchement --------------------------------------------
% La ligne ne peut traiter qu'un lot à la fois : utilisez la contrainte
% globale "disjunctive(s, dur)" (elle prend directement les tableaux de
% débuts et de durées).
%
% A COMPLETER (1 ligne) :
constraint disjunctive(s, dur); % contrainte globale



% --- ETAPE 3 : objectif = minimiser la date de fin du dernier lot ----------
var 0..horizon: makespan;
%
% A COMPLETER (2 lignes : contrainte liant makespan à max(e), puis solve minimize) :

constraint makespan = max(e); 
solve minimize makespan;


output [ noms[i] ++ " : début=" ++ show(s[i]) ++ "h, fin=" ++ show(e[i]) ++ "h\n" | i in 1..3 ]
      ++ ["makespan = ", show(makespan), "h"];

% Q2: le makespan = 12h
% On a 3h + 5h + 4h = 12h cela correspond à la borne inférieure du problème
% 12h < 15h les lots s'enchaînent 

% Q3 : 
% MiniZinc (langage déclaratif) : modélisation directe et la formulation est proche des mathématiques, les contraites globale s'applique directement sur des tableaux d'entiers sans manipuler d'objets complexes.

% OR-Tools: une API de Python orientée objet, il faut instancier l'objet avant son utilisation

% MiniZinc est plus rapide et adapaté à ce problème de programmation par contrainte






