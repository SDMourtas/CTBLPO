function [t,x]=CTBLPO(gamma,c,m,dc,dm)
tspan=[0 49]; options=odeset(); n=length(m(0)); x0=ones(n+2,1)/n;

% ZNN solutions
tic
[t,x1]=ode15s(@ZNN,tspan,x0(1:end-1),options,gamma,c,m,dc,dm);
toc
for i=1:n
subplot(n,1,i);plot(t,x1(:,i),'Color',[0.4940 0.1840 0.5560]);hold on
ylabel(['\eta_{',num2str(i),'}(t)']);
end

% LVI-PDNN solutions
tic
[t,x]=ode15s(@LVIPDNN,t,x0,options,gamma,c,m);
toc
for i=1:n
subplot(n,1,i);plot(t,x(:,i),'-.','Color',[0.4660 0.6740 0.1880]);hold on
end

% Quadprog solutions
warning off
options1=optimset('Display','off');
tot=length(t);
xth=zeros(n,tot);
fth=zeros(n,1);
tic
for k=1:tot
[xi_minus,xi_plus,W,J,A,q,d,b,~]=problem(t(k),c,m);
[xth(:,k),fth(k)]=quadprog(W,q,A,b,J,d,xi_minus,xi_plus,x0(1:n),options1);
end
toc
for i=1:n
subplot(n,1,i);plot(t,xth(i,:),':','Color',[0.9290 0.6940 0.1250]);xlim(tspan);hold on
end

xlabel('Time')
legend('ZNN','LVI-PDNN','quadprog')
hold off

kt=zeros(tot,1); kt1=zeros(tot,1);
for i=1:tot
kt(i)=x(i,1:n)*c(t(i))*x(i,1:n)';
kt1(i)=x1(i,1:n)*c(t(i))*x1(i,1:n)';
end

figure
plot(t,kt1,'Color',[0.4940 0.1840 0.5560]);hold on
plot(t,kt,'-.','Color',[0.4660 0.6740 0.1880]);
plot(t,fth,':','Color',[0.9290 0.6940 0.1250])
xlabel('Time')
ylabel('Variance %')
xticks([0 10 20 30 40 49])
xticklabels({'1/7','16/7','30/7','13/8','27/8','10/9'})
legend('ZNN','LVI-PDNN','quadprog');xlim(tspan)
hold off

kexp1=zeros(tot,1); kexp2=zeros(tot,1); kexp3=zeros(tot,1); kexp0=zeros(tot,1);
err=x(:,1:n)'-xth; err1=x1(:,1:n)'-xth;
nerr=zeros(tot,1); nerr1=zeros(tot,1);
for i=1:tot
kexp0(i)=x1(i,1:n)*m(t(i));
kexp1(i)=x(i,1:n)*m(t(i));
kexp2(i)=xth(:,i)'*m(t(i));
kexp3(i)=mean(m(t(i)));
nerr(i)=norm(err(:,i),2);
nerr1(i)=norm(err1(:,i),2);
end

figure
plot(t,kexp3,'k');hold on
plot(t,kexp0,'Color',[0.4940 0.1840 0.5560])
plot(t,kexp1,'-.','Color',[0.4660 0.6740 0.1880])
plot(t,kexp2,':','Color',[0.9290 0.6940 0.1250])
xlabel('Time')
ylabel('Equilibrium return')
legend('SMA40','ZNN','LVI-PDNN','quadprog')
xticks([0 10 20 30 40 49])
xticklabels({'1/7','16/7','30/7','13/8','27/8','10/9'});xlim(tspan)
hold off

figure
semilogy(t,nerr,'Color',[0.4660 0.6740 0.1880]); hold on
semilogy(t,nerr1,'Color',[0.4940 0.1840 0.5560]);
ylabel('||X(t)-X_{Q}(t)||^2_2');xlabel('Time');xlim(tspan)
legend('LVI-PDNN','ZNN');hold off