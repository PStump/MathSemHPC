% Testskript fuer Eigenwertberechnung wie aus dem Skript
A = [-2, 1, 0; 1, -2, 1; 0, 1, -2]
u = [1;1;1]

% loop
u = (A*u) / norm(A*u)