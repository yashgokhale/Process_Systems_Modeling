*Right node
Binary variables
y1 'attribute 1'
y2 'attribute 2';

Variable z;

Equations
objective 'Objective'
c1 'First constraint'
c2 'Second constraint'
c3 'Third constraint';

objective..z=e=1.2*y1+y2;
c1..1.2*y1+0.5*y2=l=1;
c2..y1+y2=l=1;
c3..y1=g=1;

Model opt /all/;

Solve opt using mip maximizing z;

Display y1.l,y2.l,y1.m,y2.m;