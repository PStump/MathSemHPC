% Testfile um die Ausstechmethode zu testen.
%%% Definitionen
matrixGroesse = 20;
teilMatrixGroesse = 10;

%Testmatrix
%R = spdiags(floor((1000-1)*rand(m,2*a+1)+1),-a:a,m,m);
R = zeros(matrixGroesse);

  
  %%%% naechse Durchfuehrungen, so viele wie passend
  parfor paraI = 1:(matrixGroesse/teilMatrixGroesse) %parallel for loop
	  % teilMatrixGroesse x teilMatrixGroesse Matrix Aufteilung
	  Teilmatrix = paraI-1;
		teilmatr = R(Teilmatrix*teilMatrixGroesse+1:Teilmatrix*teilMatrixGroesse+teilMatrixGroesse, Teilmatrix*teilMatrixGroesse+1:Teilmatrix*teilMatrixGroesse+teilMatrixGroesse);
		
		% Teilmatrix fuellen mit dummy Wert
		teilmatr = repmat(paraI,teilMatrixGroesse,teilMatrixGroesse);
		
		% Berechneter Eigenvektor in eigenvektor einfuegen
		R(Teilmatrix*teilMatrixGroesse+1:Teilmatrix*teilMatrixGroesse+teilMatrixGroesse, Teilmatrix*teilMatrixGroesse+1:Teilmatrix*teilMatrixGroesse+teilMatrixGroesse) = teilmatr;
  end
