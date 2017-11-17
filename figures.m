figure,
subplot(1,6,1),
Xtr = X1_train;
Ttr = T1_train;
colorData(Xtr,Ttr), title('Training')
axis tight
subplot(1,6,2),
Xte = X1_test;
Tte = T1_test;
Yte = Y1_test;
axis tight
colorData(Xte,Tte), title('Test')
subplot(1,6,3),
[W, Xsup, R2Max, lamc]= crossVaL(Yte, Xte, 500, 100);
colorData(Xsup,Tte), %title(['Supervised (R2 = ', num2str(R2Sup,2), ')'])


%%

load('Chewie_CO_FF_2016_10_07.mat')
remove_dir = [0,4,6,7];
[~,~,T0,Pos0,Vel0,~,~,~] = compile_reaching_data(trial_data,20,30,'go',remove_dir);

figure
subplot(1,2,1), colorData(normal(Vel0),T0), title('Test Data (ground truth)')
% vel0 should be veloc, and t0 should be which direction (e.g. 0:4)