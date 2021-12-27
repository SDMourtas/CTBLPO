function output=LVIPDNN(t,x,gamma,c,m)
[xi_minus,xi_plus,W,J,A,q,d,b,omegabar]=problem(t,c,m);
[s_minus,s_plus,hta,pii]=inputs(xi_minus,xi_plus,W,J,A,q,d,b,omegabar);
I=eye(size(hta));
output=gamma*(I+hta.')*(Poweromega(x-hta*x-pii,s_minus,s_plus)-x);