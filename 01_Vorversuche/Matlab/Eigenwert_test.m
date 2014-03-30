% Testmatrix
%A = [3, 0 ; -1, 2];
A = [-2, 1, 0, 0; 1, 4, 3, 0; 0, 3, 5, 6; 0, 0, 2, 3]

% eigs berechnet Eigenvektoren und Eigenwerte
[eigenvekt eigenwert] = eigs(A)

% Zeilen 1 bis 2 und Spalten 1 bis 2
subA = A(1:2, 1:2)
[eigenvekt1 eigenwert1] = eigs(subA)
A(1:2, 1:2) = eigenwert1

% Zeilen 3 bis 4 und Spalten 3 bis 4
subA = A(3:4, 3:4)
[eigenvekt1 eigenwert1] = eigs(subA)
A(3:4, 3:4) = eigenwert1

[eigenvekt2 eigenwert2] = eigs(A)