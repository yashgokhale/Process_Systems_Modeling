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
     
Alias(t,t2,tau)

Variables
z 'Objective value'
q(t,tau) 'Disaggregated amounts'
y(t) 'Decision variable';

Positive variables s(t),q(t,tau);
Binary variable y(t);

Equations
obj 'Objective'
eq1(t,tau) 'BigM'
eq2(tau) ''
eq3(t,tau);

obj.. z =e=sum(t,c(t)*y(t))+ sum((t,tau)$(ord(tau)>ord(t)-1), q(t,tau)*(p(t) + sum(t2$(ord(t2) < ord(tau) and ord(t2) >= ord(t)),h(t))));   
eq1(t,tau)..q(t,tau)=l=d(tau)*y(t);
eq2(tau)..sum(t,q(t,tau)$(ord(tau)>=ord(t)))=e=d(tau);
eq3(t,tau)$(ord(tau)>ord(t))..q(t,tau)=e=0;

*Model relaxed /all/;
*Solve relaxed using rmip minimizing z;
*Display q.l,y.l;

Model mixed /all/;
Solve mixed using rmip minimizing z;
Display q.l,y.l;

*Solution obtained for RMIP: 530;
*Solution obtained for MIP: 530;

