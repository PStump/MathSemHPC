n = 3; % nur 3 oder 4
m = 10^n;  % geht bis 10^4 danach zu langsam
mm = m/10^(n-1);
a = mm - 8;
ii = mm;
s = 1;
Iterationsschritte = 1000;
eigenvektor = zeros(1,m)';
zweite = 0; % wenn zweite = 1 dann wird die Matrix zwei mal bearbeitet
Schritt = 0;
Schritt2 = 0;
Schritt3 = 0;
Schritt4 = 0;

R = spdiags(floor((1000-1)*rand(m,2*a+1)+1),-a:a,m,m);


tic; % Eigenvektor Berechnen ohne Bearbeitung über die ganze Matrix
u = ones(1,m)';
qq = abs(u(1:1));
e = 0;
for i = 1 : 1 : Iterationsschritte
if e == 0
u = (R*u) / norm(R*u);   % Eigenvektoren 
Schritt = Schritt + 1;
end
if qq == abs(round(u(1:1)*1e6)*1e-6)
e = 1;
end
qq = abs(round(u(1:1)*1e6)*1e-6);
end
E = u' * R * u;    % Betragsmässig grösseter Eigenwert
Zeit1 = toc;


    tic; % Bearbeiten der Matrix
    for i=1 : mm : m
        eval(sprintf('P%d = R(i:ii, i:ii)',s));
        s = s + 1;
        ii = ii + mm;
    end

    if zweite == 1
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
            eval(sprintf('ll%d = (PP%d *t) / norm(PP%d *t)',i,i,i));
        end
    end
    end

    l = ones(1,mm)';
    for i=1 : 1 : m/mm
        for f = 1 : 1 : Iterationsschritte / 10
            eval(sprintf('l%d = (P%d *l) / norm(P%d *l)',i,i,i));
        end
    end

    ii = mm;
    s = 1;
    for i=1 : mm : (m-mm+1)
        eval(sprintf('eigenvektor(i:ii) = l%d',s));
        ii = ii + mm;
        s = s + 1;
    end

    if zweite == 1
    ii = mm + (mm/2);
    s = 1;
    for i=mm/2+1 : mm : (m-mm)
        eval(sprintf('eigenvektor(i:ii) = ((eigenvektor(i:ii)+ll%d)/2)',s));
        ii = ii + mm;
        s = s + 1;
    end
    end
    Bearbeitung = toc;

esse = u - eigenvektor;

e = 0;
qq = eigenvektor(1:1);
tic; % Eigenvektor berechnen von der bearbeiteten Matrix
for i = 1 : 1 : Iterationsschritte
    if e == 0
    eigenvektor = (R*eigenvektor) / norm(R*eigenvektor);
    Schritt2 = Schritt2 + 1;
    end
    if qq == abs(round(eigenvektor(1:1)*1e6)*1e-6)
    e = 1;
    end
    qq = abs(round(eigenvektor(1:1)*1e6)*1e-6); 
end
EE = eigenvektor' * R * eigenvektor;
Zeit2 = toc;

e = 0;
qq = eigenvektor(1:1);
eigenvektor2 = u;
tic; % Eigenvektor berechnen von der bearbeiteten Matrix
for i = 1 : 1 : Iterationsschritte
    if e == 0
    eigenvektor2 = (R*eigenvektor2) / norm(R*eigenvektor2);
    Schritt3 = Schritt3 + 1;
    end
    if qq == abs(round(eigenvektor2(1:1)*1e6)*1e-6)
    e = 1;
    end
    qq = abs(round(eigenvektor2(1:1)*1e6)*1e-6);
end
EEE = eigenvektor' * R * eigenvektor;
Zeit3 = toc;
clc;

Schritt
Schritt2
Schritt3
Zeit1
Zeit2
Zeit3
Bearbeitung
max(abs(esse))

clearvars;