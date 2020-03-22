Sets
i 'Foodstuffs' /f1*f20/
j 'Nutrient' /n1*n9/;

Parameters
r(j) 'Nutrient requirement'
    /n1 3
     n2 70
     n3 0.8
     n4 12
     n5 5
     n6 1.8
     n7 2.7
     n8 18
     n9 75/;
     
Table cost(i,j) 'Cost'
$ondelim
$include  foodcost.csv
$offdelim;

Variables
    x(i) 'Amount of nutrient'
    z 'Total cost';

Positive Variable x;
    
Equations
    c objective function
    requirement(j) requirement limit;
    
c.. z=e=sum(i,x(i));
requirement(j)..sum(i,cost(i,j)*x(i))=g=r(j);

Model food /all/;

Solve food using lp minimizing z;

Display x.l,x.m;
