% neuer Versuch, alles neu geschrieben
%%%

% Parameter
n = 10; % Matrix Groesse [n*n]
R = zeros(n); % Matrix mit Groesse [n*n]

% Matrix Generator (Pseudo Google Matrix; Spalten Summe = 1; Bandmatrix)
  zufall = unifrnd(0,1); % ergibt Zufaellige float Zahl [0;1]
  R(:,1) = [zufall; 1-zufall; zeros(n-2,1)]; % 1. Spalte befuellen (Zufallszahlen Summe=1, mit nullen auffuellen)

  parfor spalte = 2:n-1 % Spalten fuellen von 2.er bis n-1.er
    zufall = unifrnd(0,1); % ergibt Zufaellige float Zahl [0;1]
	  zufall1 = unifrnd(0,1-zufall);
	  R(:,spalte) = [zeros(spalte-2,1); zufall; zufall1; 1-zufall-zufall1; zeros(n-(spalte-2)-3,1)];
  end

  zufall = unifrnd(0,1);
  R(:,n) = [zeros(n-2,1); zufall; 1-zufall];
	
	% Test: Summe aller Spallten sollte Null sein
  %parfor spalte = 1:n
	%	if(sum(R(:,spalte)) > 1)
	%	  sprintf('Error Spalte: %i Summe = %f', spalte, sum(R(:,spalte)))
	%  end
	%end