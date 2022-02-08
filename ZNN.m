function output=ZNN(t,x,gamma,c,m,dc,dm)
[W,J,A,q,d,b]=problem2(t,c,m); n=length(m(t)); X=x(1:n); L=x(n+1);
[dW,dJ,dA,dq,dd,db]=problem2(t,dc,dm,1);

p=1e-8; s=3e4; N=b-A*X; R=p*s*exp(-s*N'); P=(R*A)';
dP=s*(R.*A')*(dA*X)+(R*(dA-s*A.*db))';
dPdx=s*(R.*A')*A;

E1=W*X+q+L*J'+P; dE1=-dW*X-dq-L*dJ'-dP;
E2=J*X-d; dE2=-dJ*X+dd;

M=[W+dPdx, J';J, 0];

Z=[E1;E2]; dZ=[dE1;dE2];
output=M\(-gamma*Z+dZ);