% 10 Durchgaenge ohne Normierung
parfor teil = 1:n/b 
% Originalmatrix parallel aufteilen in Teilmatrizen mit Groesse [b*b]
  
  genauGenug = 0;
  uTeilMatrix = ones(b,1);
  schritteTeilMatrix = 0;
  uTeilAlt = zeros(b,1);
	
  % R(zeile von:bis, spalte von:bis)
  teilmatrix = R( (b*(teil-1)+1:b*(teil-1)+b) , (b*(teil-1)+1:b*(teil-1)+b) );
	
  % 10 Durchgaenge ohne Normierung
  for temp=1:10
	uTeilMatrix = teilmatrix*uTeilMatrix;
  end
	
  uTeil(b*(teil-1)+1:b*(teil-1)+b) = uTeilMatrix;
end