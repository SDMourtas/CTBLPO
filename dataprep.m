function [c,m,dc,dm]=dataprep(X,s,m,views,tau)
% BL expected return and covariance construction

R=X(s+1:end,1:m); % market space without delays
perc=(views-R)./R; % percentage change

[tot1,tot2]=size(X);
Rbl=zeros(tot1-s,tot2);
Cbl{tot1-s,1}={};
P=zeros(m,tot2); 
P(1:(m+1):end)=1;
for i=1:tot1-s
    r=X(i:s+i-1,:); rr=r./max(r);
    Sigma=cov(rr); meanR=mean(rr,2);
    [~, PI] = EER(rr,meanR,Sigma);
    C=tau*Sigma; q=perc(i,:)';
    Omega=diag(diag((1-tau)*P*Sigma*P'));
    Cbl{i,1}=100*(inv(P'*(Omega\P) + inv(C)));
    Rbl(i,:)=(P'*(Omega\P)+inv(C))\(C\PI+P'*(Omega\q));
end
dRbl=zeros(tot1-s,tot2); dCbl{tot1-s,1}={};
for i=1:tot1-s
    if i~=tot1-s
        dCbl{i,1}=Cbl{i+1,1}-Cbl{i,1}; dRbl(i,:)=Rbl(i+1,:)-Rbl(i,:);
    else
        dCbl{i,1}=dCbl{i-1,1}; dRbl(i,:)=dRbl(i-1,:);
    end
end
c=@(x)linotssm(Cbl,x); m=@(x)linotsm(Rbl,x)';
dc=@(x)linotssm(dCbl,x); dm=@(x)linotsm(dRbl,x)';