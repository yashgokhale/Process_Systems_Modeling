Set i 'products' /p1*p5/;
Set j 'stages' /s1*s6/;

Table S(j,i) 'size factor'
	p1	p2	p3	p4	p5
s1	7.9	0.7	0.7	4.7	1.2
s2	2	0.8	2.6	2.3	3.6
s3	5.2	0.9	1.6	1.6	2.4
s4	4.9	3.4	3.6	2.7	4.5
s5	6.1	2.1	3.2	1.2	1.6
s6	4.2	2.5	2.9	2.5	2.1;

Table tau(j,i) 'processing time'
    p1	p2	p3	p4	p5
s1  6.4	6.8	1	3.2	2.1
s2  4.7	6.4	6.3	3	2.5
s3  8.3	6.5	5.4	3.5	4.2
s4  3.9	4.4	11.9    3.3	3.6
s5  2.1	2.3	5.7	2.8	3.7
s6  1.2	3.2	6.2	3.4	2.2;

Parameter beta(j) 'cost coefficient'
/set.j 2500/;

Parameter alpha(j) 'Cost exponent'
/set.j 0.6/;

Scalar H 'Horizon' /6200/;

Parameter D(i) 'Demand for product'
/
p1 250000
p2 150000
p3 180000
p4 160000
p5 120000/;

Variables
V(j) 'Volume of unit in stage j'
N(j) 'Number of units in stage j'
B(i) 'Size of batch of product i'
T(i) 'Cycle time for product i'
z 'Objective';

Integer Variable N(j);

Positive Variables V(j),B(i),T(i);

Equations
obj
e2(i,j)
e3
e4(i,j)
;

N.lo(j)=1;
B.lo(i)=0.00001;

obj..z=e=sum(j,N(j)*beta(j)*(V(j)**alpha(j)));
e2(i,j)..V(j)=g=S(j,i)*B(i);
e3..H=g=sum(i,(D(i)*T(i))/(B(i)));
e4(i,j)..T(i)=g=tau(j,i)/((N(j)));

Model multibatch /all/;
Solve multibatch using minlp minimizing z;
Display N.l,V.l,B.l;








