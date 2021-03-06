n = 3; % nur 3 oder 4
m = 10^n;  % geht bis 10^4 danach zu langsam
mm = m/10^(n-1);
a = mm - 9;
ii = mm;
s = 1;
Iterationsschritte = 1000;
eigenvektor = ones(1,m)';
zweite = 0; % wenn zweite = 1 dann wird die Matrix zwei mal bearbeitet
Schritt = 0;
Schritt2 = 0;
Schritt3 = 0;
Schritt4 = 0;
testMM = mm;

R = spdiags(floor((1000-1)*rand(m,2*a+1)+1),-a:a,m,m);

u = ones(1,m)';
qq = abs(u(1:1));
e = 0;

tic; % Eigenvektor Berechnen ohne Bearbeitung �ber die ganze Matrix
  for i = 1 : 1 : Iterationsschritte
    if e == 0
      u = (R*u) / norm(R*u);   % Eigenvektoren 
      Schritt = Schritt + 1;
    end
	
    if qq == abs(round(u(1:1)*1e12))
      e = 1;
    end
    qq = abs(round(u(1:1)*1e12));
  end
  E = u' * R * u;    % Betragsm�ssig gr�sseter Eigenwert
Zeit1 = toc;


SchrittBearb = 0;
mm = testMM;
tic; % Bearbeiten der Matrix
%%%% erste 10 Durchlaeufe ohne Normierung
  parfor paraI = 1:mm %parallel for loop
  	    % mm x mm Matrix Aufteilung
		matrixTeilung = paraI-1;
		teilmatrix = R(matrixTeilung*mm+1:matrixTeilung*mm+mm, matrixTeilung*mm+1:matrixTeilung*mm+mm);
		
		% Eigenvektorberechnung dieser Teilmatrix (des betragsmaesig groessten Eigenwerts)
		helpU = ones(1,mm)';
		
		for loop10=1:10  %10 Durchlaeufe ohne Normierung
		  helpU = (teilmatrix*helpU);   % Eigenvektoren
		end
		
		% Berechneter Eigenvektor in eigenvektor einfuegen
		eigenvektor(matrixTeilung*mm+1: matrixTeilung*mm+mm) = helpU;
  end

  globalNorm = norm(R*eigenvektor)
  eigenvektor = R*eigenvektor / globalNorm;
  globalNorm = norm(R*eigenvektor) % globalNorm bleibt beinahe bleich
  %eigenvektor = R*eigenvektor / globalNorm;
  %globalNorm = norm(R*eigenvektor)
  
  %%%% naechse Durchfuehrungen, so viele wie passend
  parfor paraI = 1:mm %parallel for loop
	  % mm x mm Matrix Aufteilung
	    SchrittBearb = 0;
	    matrixTeilung = paraI-1;
		teilmatrix = R(matrixTeilung*mm+1:matrixTeilung*mm+mm, matrixTeilung*mm+1:matrixTeilung*mm+mm);
		
		% Eigenvektorberechnung dieser Teilmatrix (des betragsmaesig groessten Eigenwerts)
		helpU = eigenvektor(matrixTeilung*mm+1: matrixTeilung*mm+mm);
		eigAltWert = abs(helpU(1:1));
		endWhile = 1;
		while(endWhile)% && (SchrittBearb < 5))
		  helpU = (teilmatrix*helpU) / globalNorm;   % Eigenvektoren
		  SchrittBearb = SchrittBearb + 1;
			
		  eigNeuWert = abs(round(helpU(1:1)*1e6));
			
		  if(eigAltWert == eigNeuWert)
		  endWhile = 0;
		  end
			
		  eigAltWert = eigNeuWert;
		end
		
		% Berechneter Eigenvektor in eigenvektor einfuegen
		eigenvektor(matrixTeilung*mm+1: matrixTeilung*mm+mm) = helpU;
		
		%%%%%%%% eigenvektor
		SchrittBearb
  end

  
Bearbeitung = toc;
mm = 10;
esse = u - eigenvektor;

e = 0;
qq = ones(1,m)';
tic; % Eigenvektor berechnen von der bearbeiteten Matrix
  for i = 1 : 1 : Iterationsschritte
    if 1%e == 0
    eigenvektor = (R*eigenvektor) / norm(R*eigenvektor);
    Schritt2 = Schritt2 + 1;
    end
    if qq == abs(round(eigenvektor(1,1)*1e12)) %% darf nicht an Position 1,1 sein (da dort keine Aenderung)
    e = 1;
    end
    qq = abs(round(eigenvektor(1,1)*1e12)); 
  end
  EE = eigenvektor' * R * eigenvektor;
Zeit2 = toc;

e = 0;
qq = u(1:1);
eigenvektor2 = u;
tic; % Eigenvektor berechnen von der bearbeiteten Matrix
  for i = 1 : 1 : Iterationsschritte
    if e == 0
    eigenvektor2 = (R*eigenvektor2) / norm(R*eigenvektor2);
    Schritt3 = Schritt3 + 1;
    end
    if qq == abs(round(eigenvektor2(1:1)*1e12))
    e = 1;
    end
    qq = abs(round(eigenvektor2(1:1)*1e12));
  end
  EEE = eigenvektor2' * R * eigenvektor2;
Zeit3 = toc;

%clc;

Schritt
Schritt2
Schritt3
SchrittBearb
Zeit1
Zeit2
Zeit3
Bearbeitung
max(abs(esse))
E
EE
EEE

%clearvars;