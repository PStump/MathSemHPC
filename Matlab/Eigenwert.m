% neuer Versuch, alles neu geschrieben
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter
n = 10^4; % Matrix Groesse [n*n]
b = 100; % Blockgroesse (Teilmatrizengroesse) MUSS MIT n KOMPATIEBEL SEIN
R = zeros(n); % Matrix mit Groesse [n*n]
maxSchlaufen = 100000; % maximale Schlaufendurgaenge bei Eigenvektorberechnung
maxSchlaufenTeil = 10000;
maxSchlaufenTeilSchluss = 100000;
genauigkeit = 1e4;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eigenwertberechnung original ueber gesamte Matrix
  genauGenug = 0;
  uOriginal = ones(n,1);
  schritteOriginal = 0;
  uOrigAlt = zeros(n,1);

tic;
  while( not(genauGenug) && (schritteOriginal < maxSchlaufen)) % Eigenvektorberechnung solange genau genug oder Schalufendurchgaenge genug oft
    uOriginal = (R*uOriginal) / norm(R*uOriginal);
	  schritteOriginal++ ;
	
	  % Test: ob Genauigkeit erreicht
	  if(uOrigAlt == abs(round(uOriginal*genauigkeit)))
	    genauGenug = 1;
	  end
	  uOrigAlt = abs(round(uOriginal*genauigkeit));
  end
zeitOriginal = toc
	
	eigenwertOriginal = uOriginal' * R * uOriginal
  if(schritteOriginal == maxSchlaufen)
	  sprintf('Original Eigenwertberechnung max. Schlaufen erreicht: %i',schritteOriginal)
	else
	  schritteOriginal
	end
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eigenwertberechnung mit Teilmatrizen
  uTeil = ones(n,1);
tic;
	% 10 Durchgaenge ohne Normierung
	parfor teil = 1:n/b % Originalmatrix parallel aufteilen in Teilmatrizen mit Groesse [b*b]
	  
		genauGenug = 0;
    uTeilMatrix = ones(b,1);
    schritteTeilMatrix = 0;
    uTeilAlt = zeros(b,1);
		
		%            R(zeile von:bis, spalte von:bis)
		teilmatrix = R( (b*(teil-1)+1:b*(teil-1)+b) , (b*(teil-1)+1:b*(teil-1)+b) );
		
		% 10 Durchgaenge ohne Normierung
		for temp=1:10
		  uTeilMatrix = teilmatrix*uTeilMatrix;
		end
		
		uTeil(b*(teil-1)+1:b*(teil-1)+b) = uTeilMatrix;
	end
	
	% norm Berechnung ueber gesammte Matrix
	globalNorm = norm(R*uTeil)
	uTeil = (R*uTeil) / norm(R*uTeil);
	globalNorm = norm(R*uTeil)
	uTeil = (R*uTeil) / norm(R*uTeil);
	globalNorm = norm(R*uTeil)
	
	% Teilmatrizenberechnung solang Genauigkeit oder Schlaufen max erreicht
	parfor teil = 1:n/b % Originalmatrix parallel aufteilen in Teilmatrizen mit Groesse [b*b]
	  
		genauGenug = 0;
    uTeilMatrix = ones(b,1);
    schritteTeilMatrix = 0;
    uTeilAlt = zeros(b,1);
		
		%            R(zeile von:bis, spalte von:bis)
		teilmatrix = R( (b*(teil-1)+1:b*(teil-1)+b) , (b*(teil-1)+1:b*(teil-1)+b) );
		
		% Durchgaenge mit Globaler Normierung
		for temp=1:10
		  uTeilMatrix = teilmatrix*uTeilMatrix;
		end
		uTeilAlt = zeros(b,1);

    while( not(genauGenug) && (schritteTeilMatrix < maxSchlaufenTeil)) % Eigenvektorberechnung solange genau genug oder Schalufendurchgaenge genug oft
      uTeilMatrix = teilmatrix*uTeilMatrix;% / globalNorm;
	    schritteTeilMatrix++;
	
	    % Test: ob Genauigkeit erreicht
	    if(uTeilAlt == abs(round(uTeilMatrix*genauigkeit)))
	      genauGenug = 1;
	    end
	    uTeilAlt = abs(round(uTeilMatrix*genauigkeit));
    end
		
		if(schritteTeilMatrix == maxSchlaufenTeil)
	  sprintf('Teilmatrix max. Schlaufen erreicht: %i',schritteTeilMatrix)
	  end
		uTeil(b*(teil-1)+1:b*(teil-1)+b) = uTeilMatrix;
	end
	
	% soviele Durchgaenge auf gesamter Matrix bis Genauigkeit oder Schritte max erreicht
	schritteTeilTot = 0;
	genauGenug = 0;
	uTeilTotAlt = zeros(n,1);

zeitTeilTeil = toc;
	
	while( not(genauGenug) && (schritteTeilTot < maxSchlaufenTeilSchluss)) % Eigenvektorberechnung solange genau genug oder Schalufendurchgaenge genug oft
    uTeil = (R*uTeil) / norm(R*uTeil);
	  schritteTeilTot++;
	
	  % Test: ob Genauigkeit erreicht
	  if(uTeilTotAlt == abs(round(uTeil*genauigkeit)))
	    genauGenug = 1;
	  end
	  uTeilTotAlt = abs(round(uTeil*genauigkeit));
  end
zeitTeilGesamt = toc
zeitTeilSchluss = zeitTeilGesamt - zeitTeilTeil
	
	eigenwertTeil = uTeil' * R * uTeil
  if(schritteTeilTot == maxSchlaufen)
	  sprintf('Teilmatrizen Eigenwertberechnung max. Schlaufen erreicht: %i',schritteTeilTot)
	else
	  schritteTeilTot
	end