function [W,J,A,q,d,b]=problem2(t,c,m,z)
r=m(t);
W=2*c(t);
n=length(r);
q=zeros(n,1);

if nargin==3
J=ones(1,n);
I=eye(n);
A=[-r';I;-I];
rp=min(r);
xi_plus=ones(n,1);
xi_minus=zeros(n,1);
b=[-rp;xi_plus;xi_minus];
d=1;
else
J=zeros(1,n);
I=zeros(2*n,n);
A=[-r';I];
rp=min(r);
xi=zeros(2*n,1);
b=[-rp;xi];
d=0;
end
