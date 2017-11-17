%% New section
load('binnedData_0801.mat')
load('optimal_parameters_jango_optimize_D1.mat')

monkey = Results.monkey;
removedir = Results.removedir;
whichtrain = 1; model_select =1;
whichtarg = setdiff(0:7,removedir);
Xtr = Results.Xtr;

numSfinal = Results.numS_minKL;
numDfinal = Results.numD_minKL;
sfacfinal = Results.sfac_minKL;
drmethodfinal = Results.drmethod_minKL;

Xtr = Results.Xtr;
Ttr = Results.Ttr;

[Yte1,Tte1,Xte1] = compile_jango_neuraldata(whichtarg,numSfinal,numDfinal,'binnedData_0801.mat');
[Yte2,Tte2,Xte2] = compile_jango_neuraldata(whichtarg,numSfinal,numDfinal,'binnedData_0807.mat');
[Yte3,Tte3,Xte3] = compile_jango_neuraldata(whichtarg,numSfinal,numDfinal,'binnedData_0819.mat');
[Yte4,Tte4,Xte4] = compile_jango_neuraldata(whichtarg,numSfinal,numDfinal,'binnedData_0901.mat');



%% ^ takes a while

[Vout1, ~] = runDAD2d( downsamp_nd(Yte1,sfacfinal),Xtr,drmethodfinal);
[Vout2, ~] = runDAD2d( downsamp_nd(Yte2,sfacfinal),Xtr,drmethodfinal);
[Vout3, ~] = runDAD2d( downsamp_nd(Yte3,sfacfinal),Xtr,drmethodfinal);
[Vout4, ~] = runDAD2d( downsamp_nd(Yte4,sfacfinal),Xtr,drmethodfinal);

%% 

Results.Vout1 = Vout1;
Results.Vout2 = Vout2;
Results.Vout3 = Vout3;
Results.Vout4 = Vout4;
    
Results.Yte4 = Yte4;
Results.Yte3 = Yte3;
Results.Yte2 = Yte2;
Results.Yte1 = Yte1;
    
Results.Tte4 = Tte4;
Results.Tte3 = Tte3;
Results.Tte2 = Tte2;
Results.Tte1 = Tte1;

Results.Xte4 = Xte4;
Results.Xte3 = Xte3;
Results.Xte2 = Xte2;
Results.Xte1 = Xte1;


%% graphs   - run?

figure (10),
subplot(3,4,1)
colorData(Xte1,Tte1)
title('Ground truth (D1)')

subplot(3,4,2)
colorData(Xte2,Tte2)
title('Ground truth (D2)')

subplot(3,4,3)
colorData(Xte3,Tte3)
title('Ground truth (D3)')

subplot(3,4,4)
colorData(Xte4,Tte4)
title('Ground truth (D4)')

subplot(3,4,5)
colorData(Vout1,Tte1)
title(['SmoothKL (D1), R2 = ']) % ,num2str(R2vals_DAD(1,1),2)])

subplot(3,4,6), colorData(Vout2,Tte2), 
title(['SmoothKL (D2), R2 = ']) % ,num2str(R2vals_DAD(1,2),2)])

subplot(3,4,7), colorData(Vout3,Tte3), 
title(['SmoothKL (D3), R2 = ']) % ,num2str(R2vals_DAD(1,3),2)])

subplot(3,4,8), colorData(Vout4,Tte4), 
title(['SmoothKL (D4), R2 = ']) % ,num2str(R2vals_DAD(1,4),2)])

Vout1_smooth = Vout1;
Vout2_smooth = Vout2;
Vout3_smooth = Vout3;
Vout4_smooth = Vout4;

%% other model? missing script

model_select=2; % maximum R2
%script_run2D_jango_applymodelselection % script doesn't exist

R2vals_DAD(2,1) = evalR2(Vout1,Xte1(:,1:2));
R2vals_DAD(2,2) = evalR2(Vout2,Xte2(:,1:2));
R2vals_DAD(2,3) = evalR2(Vout3,Xte3(:,1:2));
R2vals_DAD(2,4) = evalR2(Vout4,Xte4(:,1:2));

subplot(3,4,9), colorData(Vout1,Tte1)
title(['maxR2 (D1), R2 = ',num2str(R2vals_DAD(2,1),2)])
subplot(3,4,10), colorData(Vout2,Tte2), 
title(['maxR2 (D2), R2 = ',num2str(R2vals_DAD(2,2),2)])
subplot(3,4,11), colorData(Vout3,Tte3), 
title(['maxR2 (D3), R2 = ',num2str(R2vals_DAD(2,3),2)])
subplot(3,4,12), colorData(Vout3,Tte3), 
title(['maxR2 (D4), R2 = ',num2str(R2vals_DAD(2,4),2)])

%% 
% script_visualize_jango_acrossdays_graham even changed, don't have
% run_supmethods script

figure

    subplot(4,5,5*(whichtrain-1)+1), colorData(Xtr,Ttr), title(['Training Data (D',int2str(whichtrain),')'])
    subplot(4,5,5*(whichtrain-1)+2), colorData(Vout1,Tte1), title('Alignment (D1)')
    subplot(4,5,5*(whichtrain-1)+3), colorData(Vout2,Tte2), title('Alignment (D2)')
    subplot(4,5,5*(whichtrain-1)+4), colorData(Vout3,Tte3), title('Alignment (D3)')
    subplot(4,5,5*(whichtrain-1)+5), colorData(Vout4,Tte4), title('Alignment (D4)')

%% 

Xte1_int = Xte1(:,1:2);
[Xr,Hinv1a] = LSoracle_Graham(Xte1_int,Yte1); % where Xr = (Hinv*Yte')'; 
% Xte_int 972x2 for veloc, Hinv_test 2x69, and Yte1 972x69; 
Frob_Oracle = norm((Xr-Xte1_int), 'fro')


%[Xr1b, Hinv1b] = LSoracle_Graham(Xtest,Ytest);


% min over H ||Ytr - XtrHtr|| and hopefully Yte about = XeHtr
% Yte*pinv(Htr) = Xte*
% error is frob norm of || Xte-Xte*||
% n = norm(X,'fro') returns the Frobenius norm of matrix X.

%% supervised methods (oracle, kalman, linear decoder)

%update with proper data

Xtrain = Xte1_int;
Xtest = Xtrain;
Ytrain = Yte1; 
Ytest = Ytrain;




% oracle decoder
Xr = LSoracle_Graham(Xtrain,Ytrain);
Xr2 = LSoracle_Graham(Xtest,Ytest);


Xtrain = Xte1_int;
Xtest = Xtrain;
Ytrain = Yte1; 
Ytest = Ytrain;
% kalman filter
[A, C, Q, R] = train_kf(Xtrain,Ytrain);
[Xkf, ~, ~, ~] = kalman_filter(Ytrain', A, C, Q, R, zeros(2,1), eye(2));
[Xkf2, ~, ~, ~] = kalman_filter(Ytest', A, C, Q, R, zeros(2,1), eye(2));
Frob_kl = norm((Xkf'-Xtrain), 'fro')


% supervised linear decoder
[W, ~, ~, ~]= crossVaL(Ytrain, Xtrain, 500, 100); % finds lambda values I think ( ||X-YH| + lambda||H|| )
Xsup = [Ytrain, ones(size(Ytrain,1),1)]*W;
Xsup2 = [Ytest, ones(size(Ytest,1),1)]*W;
Frob_supldec = norm((Xsup-Xtrain), 'fro')

frob_oracleKLsupldec = [Frob_Oracle, Frob_kl, Frob_supldec];

%%
% evaluate error metrics (on train and test)
R2Vals = [ [evalR2(Xr,Xtrain), evalR2(Xr2,Xtest)], [evalR2(Xkf',Xtrain), evalR2(Xkf2',Xtest)], [evalR2(Xsup,Xtrain), evalR2(Xsup2,Xtest)] ];
%PcorrVals = [ [evalTargetErr(Xr,normal(Xtrain),Ttrain), evalTargetErr(Xr2,normal(Xtest),Ttest)], [evalTargetErr(Xkf',normal(Xtrain),Ttrain), evalTargetErr(Xkf2',normal(Xtest),Ttest)], [evalTargetErr(Xsup,normal(Xtrain),Ttrain), evalTargetErr(Xsup2,normal(Xtest),Ttest)] ];
%MSEVals = [ [evalMSE(Xr,Xtrain), evalMSE(Xr2,Xtest)], [evalMSE(Xkf',Xtrain), evalMSE(Xkf2',Xtest)], [evalMSE(Xsup,Xtrain), evalMSE(Xsup2,Xtest)] ];

% Results.Tte_smooth 
% from script_run3d_mihi_main_mperich
%%
%%%% Supervised methods (run oracle and kalman filter)
% Xr = LSoracle(Xte,Yte);
% R2Oracle = evalR2(Xr,Xte);  
% PcorrOracle = evalTargetErr(Xr,Xte,Tte);
% 
% [~,~,tmp,~] = rotated_KLmin(Xr,Xtr,90);
% minKLOracle = min(tmp(:));
% 
% [W, Xsup, R2Max, lamc]= crossVaL(Yte, Xte, 500, 100);
% R2Sup = evalR2(Xsup,Xte); 
% PcorrSup = evalTargetErr(Xsup,Xte,Tte);
% 
% [~,~,tmp,~] = rotated_KLmin(Xsup,Xtr,90);
% minKLSup = min(tmp(:));
% and has some visualization to add!!!