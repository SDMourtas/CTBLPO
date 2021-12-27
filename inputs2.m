function [hta,pii,Q,S,du]=inputs2(W,J,A,q,d,b,dW,dJ,dA,dq,dd,db,x)
p=1e-8; s=3e4; N=b-A*x;
P1=p*s*(exp(-s*N')*A)';
P2=p*s^2*(exp(-s*N').*A')*A;
P3=p*s^2*(exp(-s*N').*A')*dA;
P4=p*s*(exp(-s*N')*(dA-s*A.*db))';

n=size(J.',2); J2=zeros(size(J,1),n);
hta=[W J.';J J2];
pii=[-q-P1;d];
Q=[W+P2 J.';J J2];
S=[dW+P3 dJ.';dJ J2];
du=[-dq-P4;dd];