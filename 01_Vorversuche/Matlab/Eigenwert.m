%dünnbestzte matrix n x m sollte quadratisch sein f = Besetzungszahl in
%Prozent
mm = 6; % Matrix grösse
m = mm * 17;  % geht bis 10^4 danach zu gross
f = 0.05; % 0.05 sehr dünn besetzt 
s = 1;
ii = mm;
a = 1; % Aufteilung Bandmatrix
d = [1:10];


%R = sprand(m,m,f); % dünnbestezte Matrix
R = spdiags(rand(m,2*a+1),-a:a,m,m);
RR = R;
RRR = zeros(m);

% In Matrizen aufteilen
tic;
for i=1 : mm : m
    eval(sprintf('P%d = R(i:ii, i:ii)',s));
    s = s + 1;
    ii = ii + mm;
end

% Eigenwerte berechnen
for i=1 : 1 : m/mm
    eval(sprintf('P%d = eigs(P%d)',i,i));
end

% eigenwerte in quadratuische Matrizen erstellen und diagonalisieren
for i = 1 : 1 : m/mm
    eval(sprintf('P%d = diag(P%d)',i,i));
end

% In ursprüngliche Matrix wieder einsetzen
s = 1;
ii = mm;

for i = 1 : mm : m
    eval(sprintf('RR(i:ii, i:ii) = P%d',s));
    s = s + 1;
    ii = ii + mm;
end
ZeitFuerAufteilung = toc;


    % Beispiel Eigenwerte ausrechnen und Restliche matrix mit Nullen aufgefüllt
    s = 1;
    ii = mm;
    for i = 1 : mm : m
        eval(sprintf('RRR(i:ii, i:ii) = P%d',s));
        s = s + 1;
        ii = ii + mm;
    end

        % Beispiel mit Zusätzlichen Matrizen nach (m/2) unten und (m/2) rechts verschoben
        RRRR = RR;
        s = 1;
        ii = 1.5*mm;
        for i=4 : mm : m-10
            eval(sprintf('PP%d = R(i:ii, i:ii)',s));
            s = s + 1;
            ii = ii + mm;
        end

        % Eigenwerte berechnen
        for i=1 : 1 : (m/mm)-2
            eval(sprintf('PP%d = eigs(PP%d)',i,i)); 
        end

        % eigenwerte in quadratuische Matrizen erstellen und diagonalisieren
        for i = 1 : 1 : (m/mm)-2
            eval(sprintf('PP%d = diag(PP%d)',i,i));
        end
         % In ursprungliche Matrix einsetzen und Eigenwerte zusammenzählen
        s = 1;
        ii = 1.5*mm;
        for i = 4 : mm : m-10
            eval(sprintf('RRRR(i:ii, i:ii) =  PP%d',s));
            s = s + 1;
            ii = ii + mm;
        end


tic;
OriginalMatrix = eigs(R); % gibt die 6 Grössten Eigenvektoren raus --> Konvergieren nicht immer
ZeitOriginaleMatrix = toc

tic;
ErsteBearbeitung = eigs(RR);
ZeitBearbeiteteMatrix = toc

tic;
BearbeitungMitNullen = eigs(RRR);
ZeitBearbeiteteMatrixMitNullen = toc

tic;
DoppelteBearbeitung = eigs(RRRR);
ZeitBearbeiteteMatrixMitZweiMalMatrizen = toc

ZeitBearbeitung =  ZeitBearbeiteteMatrix


spy(R)
figure
spy(RR)
figure
spy(RRR)
figure
spy(RRRR)

OriginalMatrix 
ErsteBearbeitung 
DifferenzZuOriginal = OriginalMatrix - ErsteBearbeitung
BearbeitungMitNullen
DifferenzZuOriginal = OriginalMatrix - BearbeitungMitNullen
DoppelteBearbeitung
DifferenzZuOriginal = OriginalMatrix - DoppelteBearbeitung

%whos % zeigt grösse der Matrix an

%clearvars;