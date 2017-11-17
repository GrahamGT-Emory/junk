
%% 

load('binnedData_0801.mat')
emgsig = binnedData.emgdatabin;
figure, plot(emgsig)
figure, plot(emgsig(:,2))
forcesig = binnedData.forcedatabin;
[Xr,Hinv] = LSoracle(forcesig,emgsig); 
figure
subplot(1,2,2), plot(Xr(:,1), Xr(:,2), '*'), title('Oracle Prediction of force from EMG'), axis equal, axis tight, xlabel('force X'), ylabel('force Y')% gives really cool reaching graph     diff units?
set(gca,'xtick',[])
set(gca,'ytick',[])

Xtrain = forcesig; Ytrain = emgsig;
[A, C, Q, R] = train_kf(Xtrain,Ytrain); %
[Xkf, ~, ~, ~] = kalman_filter(Ytrain', A, C, Q, R, zeros(2,1), eye(2));
[Xkf2, ~, ~, ~] = kalman_filter(Ytest', A, C, Q, R, zeros(2,1), eye(2));

[W, ~, ~, ~]= crossVaL(Ytrain, Xtrain, 500, 100); %sup
Xsup = [Ytrain, ones(size(Ytrain,1),1)]*W;
Xsup2 = [Ytest, ones(size(Ytest,1),1)]*W;

subplot(1,2,1), plot(forcesig(:,1), forcesig(:,2), '*'), title('Actual data'), axis equal, axis tight, xlabel('force X'), ylabel('force Y') % gives same for actual data
set(gca,'xtick',[])
set(gca,'ytick',[])

set(gca,'xticklabel',[])

evalR2(Xr,forcesig)% .8767 for predicting force from emg
vsig = binnedData.velocbin;
[Xr,Hinv] = LSoracle(vsig,emgsig);
evalR2(Xr,vsig) % -.26
[Xr,Hinv] = LSoracle(vsig,emgsig(:,2:end));
evalR2(Xr,vsig) % -.3755
% [Xr,Hinv] = LSoracle(vsig,emgsig(:,2));
% evalR2(Xr,vsig)
% [Xr,Hinv] = LSoracle(vsig,emgsig(:,2:3));
% evalR2(Xr,vsig)
neuralsig = binnedData.spikeratedata;
[Xr,Hinv] = LSoracle(emgsig(:,2:3),neuralsig);
evalR2(Xr,vsig)
evalR2(Xr,emgsig(:,2:3))   % .3111
[Xr,Hinv] = LSoracle(emgsig(:,4),neuralsig);
evalR2(Xr,emgsig(:,4)) %.46 using one channel of emg to predict neual signal or flip that
[Xr,Hinv] = LSoracle(emgsig(:,3),neuralsig);
evalR2(Xr,emgsig(:,3)) %.37 using one channel of emg to predict neual signal or flip that
[Xr,Hinv] = LSoracle(emgsig(:,2),neuralsig);
evalR2(Xr,emgsig(:,2)) %.25 using one channel of emg to predict neual signal or flip that
[Xr,Hinv] = LSoracle(emgsig(:,5),neuralsig);
evalR2(Xr,emgsig(:,5)) %.37 using one channel of emg to predict neual signal or flip that
[Xr,Hinv] = LSoracle(emgsig(:,2:5),neuralsig);
evalR2(Xr,emgsig(:,2:5)) %.2 using most of the 8 or 9 channels





x = lsqnonneg(neuralsig,emgsig(:,4))
out = neuralsig*x;
figure, plot(out), hold on, plot(emgsig(:,4),'--')
out(find(out<=4))=4; figure, plot(out), hold on, plot(emgsig(:,4),'--')
evalR2(out,emgsig(:,4))   % .2879

% emg_smooth = envelope(emgsig(:,4),10,'RMS');
% figure, plot(emg_smooth)
% figure, plot(sort(emg_smooth,'descend'))
% figure, plot(diff(sort(emg_smooth,'descend')))
% figure, plot(emg_smooth.*(emg_smooth>8.25))
% sig1 = emg_smooth.*(emg_smooth>8.25);
% clc
[Xr,Hinv] = LSoracle(sig1,neuralsig);
evalR2(sig1,Xr) %.45 for smoothed emg and neural signal
