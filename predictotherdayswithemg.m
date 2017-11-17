
%% other days and smoothing
%% 
load('binnedData_0801.mat')
whichtargets = 1:2:8;
numSamp = 10;
numDelay = 1;
filename = 'binnedData_0801.mat';
[Y1, T1, X1] = compile_jango_neuraldata_emgforce(whichtargets,numSamp,numDelay,filename);

%%
emgsig = Y1;
emgsig = emgsig(:,2:9);
figure, plot(emgsig)
figure, plot(emgsig(:,2))
forcesig1 = X1;
[Xr,Hinv] = LSoracle(forcesig1,emgsig); 
figure
subplot(4,2,2), plot(Xr(:,1), Xr(:,2), '*'), title('Oracle Prediction of force from EMG'), axis equal, axis tight, xlabel('force X'), ylabel('force Y')% gives really cool reaching graph     diff units?
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,2,1), plot(forcesig1(:,1), forcesig1(:,2), '*'), title('Ground Truth'), axis equal, axis tight, xlabel('force X'), ylabel('force Y') % gives same for actual data
set(gca,'xtick',[])
set(gca,'ytick',[])

%% day 2 

filename = 'binnedData_0807.mat';
[Y1, T1, X1] = compile_jango_neuraldata_emgforce(whichtargets,numSamp,numDelay,filename);
emgsig = Y1;
forcesig2 = X1;
%[Xr,Hinv] = LSoracle(forcesig,emgsig); 
%Hinv = Hinv from day 1;
Xr2 = (Hinv*emgsig2')'; 

subplot(4,2,4), plot(Xr2(:,1), Xr2(:,2), '*'), title('Oracle Prediction of force from Hinv after a week'), axis equal, axis tight, ylim([-3 3]), xlabel('force X'), ylabel('force Y')% gives really cool reaching graph     diff units?
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,2,3), plot(forcesig2(:,1), forcesig2(:,2), '*'), title('Ground Truth'), axis equal, axis tight, xlabel('force X'), ylabel('force Y') % gives same for actual data
set(gca,'xtick',[])
set(gca,'ytick',[])

%% day 3

filename = 'binnedData_0819.mat';
[Y1, T1, X1] = compile_jango_neuraldata_emgforce(whichtargets,numSamp,numDelay,filename);
emgsig = Y1;
forcesig3 = X1;
%[Xr,Hinv] = LSoracle(forcesig,emgsig); 
%Hinv = Hinv from day 1;
Xr3 = (Hinv*emgsig')'; 

subplot(4,2,6), plot(Xr3(:,1), Xr3(:,2), '*'), title('Oracle Prediction of force from Hinv after 2 weeks'), axis equal, axis tight, xlim([-2 2]), ylim([-3 3]), xlabel('force X'), ylabel('force Y')% gives really cool reaching graph     diff units?
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,2,5), plot(forcesig3(:,1), forcesig3(:,2), '*'), title('Ground Truth'), axis equal, axis tight, xlim([-6000 4000]), ylim([-6000 3000]), xlabel('force X'), ylabel('force Y') % gives same for actual data
set(gca,'xtick',[])
set(gca,'ytick',[])

%% day 4

filename = 'binnedData_0901.mat';
[Y1, T1, X1] = compile_jango_neuraldata_emgforce(whichtargets,numSamp,numDelay,filename);
emgsig = Y1;
forcesig4 = X1;
%[Xr,Hinv] = LSoracle(forcesig,emgsig); 
%Hinv = Hinv from day 1;
Xr4 = (Hinv*emgsig')'; 

subplot(4,2,8), plot(Xr4(:,1), Xr4(:,2), '*'), title('Oracle Prediction of force from Hinv after a month'), axis equal, axis tight, ylim([-3 3]), xlabel('force X'), ylabel('force Y')% gives really cool reaching graph     diff units?
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,2,7), plot(forcesig4(:,1), forcesig4(:,2), '*'), title('Ground Truth'), axis equal, axis tight, xlabel('force X'), ylabel('force Y') % gives same for actual data
set(gca,'xtick',[])
set(gca,'ytick',[])

%% r2 assessment
% R2 = [];
% evalR2 (Xr(1:1000, :), forcesig(1:1000, :))
% R2 = [R2; evalR2 (Xr(1:1000, :), forcesig(1:1000, :))]
% R2 = [R2; evalR2 (Xr, forcesig)];
% R2 = [R2; evalR2 (Xr, forcesig)];
% R2 = [R2; evalR2 (Xr, forcesig)];
n1 = norm((Xr(1:1000, :)- forcesig1(1:1000, :)),'fro')
n2 = norm((Xr2(1:1000, :)- forcesig2(1:1000, :)),'fro')
n3 = norm((Xr3(1:1000, :)- forcesig3(1:1000, :)),'fro')
n4 = norm((Xr4(1:1000, :)- forcesig4(1:1000, :)),'fro')

figure
plot([1, 7, 17, 30], [n1 n2 n3 n4]), xlabel('day'), ylabel('frob norm')
