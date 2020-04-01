Set x 'species' /x1*x14/;
Set m(x) 'metabolites' /x1*x5/;
set e(x) 'enzymes' /x6*x14/;

Parameter eqlb(x) 'Equilibrium concentration'
/x1 0.0345
 x2 1.011
 x3 9.144
 x4 0.0095
 x5 1.1278
 x6 19.7
 x7 68.7
 x8 31.7
 x9 49.9
 x10 3440
 x11 14.31
 x12 203
 x13 25.1
 x14 0.042/;
 
Parameter f(m) 'Forward coefficient'
/x1 0.8122
 x2 2.8632
 x3 0.5232
 x4 0.022
 x5 0.0913/;
 
Parameter b(m) 'Backward coefficient'
/x1 2.8632
 x2 0.5239
 x3 0.0148
 x4 0.0945
 x5 3.2097/;
 
Table fp(m,x) 'Forward coefficient'
	x1	x2	x3	x4	x5	x6	x7	x8	x9	x10	x11	x12	x13	x14
x1		-0.2344				1								
x2	0.7464				0.0243		1							
x3		0.7318			-0.3941			1						
x4			0.6159		0.1308				1					-0.6088
x5			0.333	0.266	0.024				0.5	0.5				-0.304;


Table bp(m,x) 'Backward coefficient'
	x1	x2	x3	x4	x5	x6	x7	x8	x9	x10	x11	x12	x13	x14
x1	0.7464				0.0243		1							
x2		0.735			-0.394			0.999			0.001			
x3			0.584	0.03	0.119				0.944			0.056		-0.575
x4			0.05	0.533	-0.0822					1				
x5	0.198	0.196			0.372		0.265	0.265			0.0002		0.47;	
	
Variables
s(x) 'Species log'
z 'Objective';


Equations
ob'Objective'
e1(m)'Steady state Mass Balance'
e2 'Fixed value 1'
e3 'Fixed value 2'
e4 'Fixed value 3'
e5(m) 'Metabolites lower bound'
e6(m) 'Metabolites upper bound'
e7(e) 'enzyme lower bound'
e8(e) 'enzyme upper bound'
;

ob..z=e=log(0.0945)+0.05*s('x3')+0.533*s('x4')-0.0822*s('x5')+s('x10');
e1(m)..log(f(m))+sum(x,fp(m,x)*s(x))=e=log(b(m))+sum(x,bp(m,x)*s(x));
e2..s('x11')=e=log(14.31);  
e3..s('x12')=e=log(203);
e4..s('x14')=e=log(0.042);
e5(m)..s(m)=g=log(0.8*eqlb(m));
e6(m)..s(m)=l=log(1.2*eqlb(m));
e7(e)..s(e)=g=log(1*eqlb(e));
e8(e)..s(e)=l=log(50*eqlb(e));

Model SS /all/;
Solve SS using lp maximizing z;
Display z.l,s.l;

