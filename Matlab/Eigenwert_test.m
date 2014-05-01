% eigs Funktion von http://www.tm-mathe.de/Themen/html/losung_von_matrizeneigenwertpr.html
% Testmatrix
%A = [3, 0 ; -1, 2];
A = [-2, 1, 0, 0; 1, 4, 3, 0; 0, 3, 5, 6; 0, 0, 2, 3]

% eigs berechnet Eigenvektoren und Eigenwerte
[eigenvekt eigenwert] = eigs(A)

% Zeilen 1 bis 2 und Spalten 1 bis 2
subA = A(1:2, 1:2)
[eigenvekt1 eigenwert1] = eigs(subA)
B(1:2, 1:2) = eigenwert1

% Zeilen 3 bis 4 und Spalten 3 bis 4
subA = A(3:4, 3:4)
[eigenvekt11 eigenwert11] = eigs(subA)
B(3:4, 3:4) = eigenwert11

[eigenvekt2 eigenwert2] = eigs(B)

% Eigenvektoren in den Ausgangsvektor schreiben
u=[eigenvekt1(:,1);eigenvekt11(:,1)]
%u=[1;1;1;1]
%u=(B*u)/norm(B*u)

% Iteration u = (A*u) / norm(A*u)
% Eigewertberechnung aus dem Eigenvektor
u' * B * u