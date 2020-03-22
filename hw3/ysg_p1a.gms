Set t 'time period' /t1*t10/;

Parameter p(t) /set.t 1/;

Parameter h(t) /set.t 1/;

Parameter c(t) /set.t 10/;

Parameter d(t)
    /t1 10
     t2 20
     t3 30
     t4 40
     t5 50
     t6 60
     t7 70
     t8 80
     t9 40
     t10 30/;
     
Scalar M /430/;
     
Variables
z 'Objective value'
s(t) 'Inventory'
x(t) 'Production amounts'
y(t) 'Decision variable';

Positive variables s(t),x(t);
Binary variable y(t);

Equations
obj 'Objective'
lim(t)
eq1(t) 'Inventory'
eq2(t) 'Decision'
eq3 'Base case';

obj.. z=e=sum(t,c(t)*y(t)+p(t)*x(t)+h(t)*s(t));
lim(t)..y(t)=l=1;
eq1(t)$(ord(t)<>1)..s(t)=e=s(t-1)+x(t)-d(t);
eq2(t)..x(t)=l=M*y(t);
eq3..s('t1')=e=x('t1')-d('t1');

Model relaxed /all/;
Solve relaxed using rmip minimizing z;
Display s.l,x.l,y.l;

*Model mixed /all/;
*Solve mixed using mip minimizing z;
*Display s.l,x.l,y.l;

*Solution obtained for RMIP: 440;
*Solution obtained for MIP: 530;
