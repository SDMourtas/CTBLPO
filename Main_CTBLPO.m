%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Source codes for the CTBLPO problem (version 1.0)                %
%                                                                   %
%  Developed in MATLAB R2021a                                       %
%                                                                   %
%  Author and programmer: S.D.Mourtas, V.N.Katsikis                 %
%                                                                   %
%   e-Mail: spirosmourtas@gmail.com                                 %
%           vaskatsikis@econ.uoa.gr                                 %
%                                                                   %
%   Main paper: S.D.Mourtas, V.N.Katsikis,                          %
%               "Continuous-Time Black-Litterman Portfolio          %
%               Optimization: A Neural Network Approach,"           %
%               (submitted)                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

s=40;                    % number of delays for average and cov matrix
X1=xlsread('data1');     % stocks close prices (included delays)
views=xlsread('data1_views'); % investor views on X1 (without delays)...
                              % created by WASDTS neuroret
X2=xlsread('data2');     % more stocks close prices (included delays)

% Example settings: m+n stocks market, where m include views
% m: number of stocks with views
% n: number of stocks without views 

m=2;n=2;   % Example 1
%m=8;n=8;   % Example 2
%m=20;n=20; % Example 3

tau=0.9; % Parameter which defines the total weight given to passive...
         % versus active investment views.
views=views(:,1:m);                   % views
X=[X1(:,1:m) X2(:,1:n)];              % market space
[Rbl,Cbl,dRbl,dCbl]=dataprep(X,s,m,views,tau);

gamma=1e6; % NN design parameter
[t1,x1]=CTBLPO(gamma,Rbl,Cbl,dRbl,dCbl);