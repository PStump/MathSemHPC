n = 4; % nur 3 oder 4
m = 10^n;  % geht bis 10^4 danach zu langsam
mm = m/10^(n-1);
a = mm - 2;
ii = mm;
s = 1;
zweite = 0; % wenn zweite = 1 dann wird die Matrix zwei mal bearbeitet
Iterationsschritte = 1000;
eigenvektor = zeros(1,m)';
SchrittEiner = 0;
SchrittBearbeitet = 0;
SchrittRandom = 0;
Schritt4 = 0;

R = spdiags(rand(m,2*a+1),-a:a,m,m);
spy(R)

tic; % Eigenvektor Berechnen ohne Bearbeitung über die ganze Matrix
u = ones(1,m)';
qq = abs(u(1:m));
e = 0;
for i = 1 : 1 : Iterationsschritte
if e == 0
u = (R*u) / norm(R*u);   % Eigenvektoren 
SchrittEiner = SchrittEiner + 1;
end
if qq == abs(round(u(1:m)*1e6)*1e-6)
e = 1;
end
qq = abs(round(u(1:m)*1e6)*1e-6);
end
EigenwertNormalBerechnet = u' * R * u;    % Betragsmässig grösseter Eigenwert
ZeitEiner = toc;

    tic; % Bearbeiten der Matrix
    for i=1 : mm : m
        eval(sprintf('P%d = R(i:ii, i:ii)',s));
        s = s + 1;
        ii = ii + mm;
    end
    
    if zweite == 1 % 2. Bearbeitung der Matrix
ii = mm + (mm/2);
s = 1;
for i=mm/2+1 : mm : m-mm
    eval(sprintf('PP%d = R(i:ii, i:ii)',s));
    s = s + 1;
    ii = ii + mm;
end
t = ones(1,mm)';
for i=1 : 1 : m/mm - 1
    for f = 1 : 1 : Iterationsschritte / 10
        eval(sprintf('ll%d = (PP%d *t)',i,i));
    end
end
end




    l = ones(1,mm)';
    for i=1 : 1 : m/mm
        %eval(sprintf('n%d = norm(P%d * l)',i,i));
        for f = 1 : 1 : 10
            eval(sprintf('l%d = P%d * l ',i,i));
        end
    end

    ii = mm;
    s = 1;
    for i=1 : mm : (m-mm+1)
        eval(sprintf('eigenvektor(i:ii) = l%d',s));
        ii = ii + mm;
        s = s + 1;
    end
       dd = eigenvektor;
        
            if zweite == 1
    ii = mm + (mm/2);
    s = 1;
    for i=mm/2+1 : mm : (m-mm)
        eval(sprintf('eigenvektor(i:ii) = ((eigenvektor(i:ii)+ll%d)/2)',s));
        ii = ii + mm;
        s = s + 1;
    end
            end
    %eigenvektor = eigenvektor * norm(eigenvektor);
    Bearbeitung = toc;

e = 0;
qq = eigenvektor(1:m);

tic; % Eigenvektor berechnen von der bearbeiteten Matrix
for i = 1 : 1 : Iterationsschritte
    if e == 0
    eigenvektor = (R*eigenvektor)/norm(R*eigenvektor);  
    SchrittBearbeitet = SchrittBearbeitet + 1;
    end
    if qq == abs(round(eigenvektor(1:m)*1e6)*1e-6)
    e = 1;
    end
    qq = abs(round(eigenvektor(1:m)*1e6)*1e-6); 
end
EigenwertBearbeiteteMatrix = eigenvektor' * R * eigenvektor;
ZeitBearbeitet = toc;

e = 0;
qq = eigenvektor(1:m);
eigenvektor2 = rand(1,m)';
tic; % Eigenvektor berechnen mit Random werten
for i = 1 : 1 : Iterationsschritte
    if e == 0
    eigenvektor2 = (R*eigenvektor2) / norm(R*eigenvektor2);
    SchrittRandom = SchrittRandom + 1;
    end
    if qq == abs(round(eigenvektor2(1:m)*1e6)*1e-6)
    e = 1;
    end
    qq = abs(round(eigenvektor2(1:m)*1e6)*1e-6);
end
EigenwertMitRandomVektor = eigenvektor2' * R * eigenvektor2;
Zeitrandom = toc;
clc;

SchrittEiner
SchrittBearbeitet
SchrittRandom
ZeitEiner
ZeitBearbeitet
EigenwertNormalBerechnet
EigenwertBearbeiteteMatrix
EigenwertMitRandomVektor

max(dd - u)

clearvars;