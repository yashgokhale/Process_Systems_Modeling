Sets
    i 'cargos' /i1*i4/
    j 'compartments' /j1*j3/;
    
Parameters
    w(j) 'Weight capacity'
    /j1 12
     j2 18
     j3 10/
     
    s(j) 'Space capacity'
    /j1 7000
     j2 9000
     j3 5000/
     
    a(i) 'Availability'
    /i1 20
     i2 16
     i3 25
     i4 13/
     
    v(i) 'Volume'
    /i1 500
     i2 700
     i3 600
     i4 400/
     
    p(i) 'Profit'
    /i1 320
     i2 400
     i3 360
     i4 290/;
     
Variables
    x(i,j) quantities
    z      total profit;
    
Positive variable x;

Equations
    profit objective function
    vol(j)    volume constraint
    weight(j) weight constraint
    cargo(i) availability;
    
profit.. z=e=sum((i,j),p(i)*x(i,j));
vol(j).. sum(i,v(i)*x(i,j))=l=s(j);
weight(j).. sum(i,x(i,j))=l=w(j);
cargo(i)..sum(j,x(i,j))=l=a(i);

Model transport /all/;

Solve transport using lp maximizing z;

Display x.l,x.m;

