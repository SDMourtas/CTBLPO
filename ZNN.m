function output=ZNN(t,x,gamma,c,m,dc,dm)
[W,J,A,q,d,b]=problem2(t,c,m); n=length(m(t));
[dW,dJ,dA,dq,dd,db]=problem2(t,dc,dm,1);
[hta,pii,Q,S,du]=inputs2(W,J,A,q,d,b,dW,dJ,dA,dq,dd,db,x(1:n));
E=hta*x-pii;
output=pinv(Q)*(-gamma*E-S*x+du);