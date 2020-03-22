Sets
i 'missions' /m1*m14/
j 'time period' /t1*t5/;

Parameters
    v(i) 'Value of mission'
    /m1 200
     m2 3
     m3 20
     m4 50
     m5 70
     m6 20
     m7 5
     m8 10
     m9 200
     m10 150
     m11 18
     m12 8
     m13 300
     m14 185/
     
    b(j) 'Budget'
    / t1 10
      t2 12
      t3 14
      t4 14
      t5 14/
      
Table c(i,j) 'Cost'
$ondelim
$include  nasa.csv
$offdelim;

Variable z;

Binary variable
y(i) 'Mission selection';

Equations
    objective 'Objective'
    e1(j) 'budget'
    e2 'Mutually Exclusive 1'
    e3 'Mutually Exclusive 2'
    e4 'Mutually Exclusive 3'
    e5 'Dependancy 1'
    e6 'Dependancy 2'
    e7 'Dependancy 3'
    e8 'Dependancy 4'
    e9 'Dependancy 5';
    
objective..z=e=sum(i,v(i)*y(i));
e1(j).. sum(i,c(i,j)*y(i))=l=b(j);
e2..y('m4')+y('m5')=l=1;
e3..y('m8')+y('m11')=l=1;
e4..y('m9')+y('m14')=l=1;
e5..y('m4')=l=y('m3');
e6..y('m5')=l=y('m3');
e7..y('m6')=l=y('m3');
e8..y('m7')=l=y('m3');
e9..y('m11')=l=y('m2');

Model nasa /all/;

Solve nasa using mip maximizing z;

Display y.l,y.m;

    



