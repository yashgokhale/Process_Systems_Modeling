Set
i 'Features' /f1*f6/;

Parameters
    c(i) 'Cost of component'
    /f1 10.2
     f2 6
     f3 23
     f4 11.1
     f5 9.8
     f6 31.6/
     
    g(i) 'Speed gain'
    /f1 8
     f2 3
     f3 15
     f4 7
     f5 10
     f6 12/;

Variable z;
     
Binary variable
y(i) decision variables;

Equations
    objective  'objective function'
    gain     'minimum gain';
    
objective..z=e=sum(i,y(i)*c(i));
gain..sum(i,y(i)*g(i))=g=30;

Model carracing /all/;

Solve carracing using mip minimizing z;

Display y.l,y.m;