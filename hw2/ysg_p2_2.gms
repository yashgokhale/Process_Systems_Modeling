Binary variables y1,y2,y3,y4,y5;
Positive variables xa,xb1,xbb,xb,xb2,xb3,xc2,xc3,xc;
Variable z;
Positive variable xco;
Variable xs;

Equations
z2 'objective'
e1 'mass balance'
e2 'mass balance'
e3 'mass balance'
e4 'mass balance'
e5 'mass balance'
e6 'exclusivity'
e7 'exclusivity'
e8 'mass balance'
e9 'limit'
e10 'limit'
e11 'limit'
e12 'limit'
e13 'excess condition'
e14 'excess condition'
e15 'limit'
e16 'mass balance'
e17 'limit';

z2.. z=e=1800*xco+1500*xs-(1000*y1+250*xa+1500*y2+400*xb2+2000*y3+550*xb3+500*xa+950*xbb);
e1.. xb1+xbb=e=xb;
e2.. xb2+xb3=e=xb;
e3.. xc2+xc3=e=xc;
e4.. xc2=e=0.82*xb2;
e5.. xc3=e=0.95*xb3;
e6.. y2+y3=e=1;
e7.. y1+y4=e=1;
e8.. xc=l=15;
e9.. xb1=e=0.9*xa;
e10.. xa=l=16*y1;
e11..xb2=l=16*0.9*y2;
e12..xb3=l=16*0.9*y3;
e13..xs=g=0;
e14..xs=l=5*y5;
e15..xc=l=10+5*y5;
e16..xc=e=xco+xs;
e17..xco=l=10;

Model plant /all/;

option solver=alphaecp

Solve plant using mip maximizing z;

Display xa.l,xb1.l,xbb.l,xb.l,xb2.l,xb3.l,xc2.l,xc3.l,xc.l;

Display y1.l,y2.l,y3.l,y4.l;

Display xco.l,xs.l,xc.l;