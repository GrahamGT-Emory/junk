clear all
close all
clc
%% from apply 2d model select, need to have a results structure already
load('optimal_parameters_jango_optimize_D1.mat')

removedir = [0,1,2,6];
whichtarg = setdiff(0:7,removedir);
whichtrain = 1; model_select =1;

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

[Vout1, ~] = runDAD2d( downsamp_nd(Yte1,sfacfinal),Xtr,drmethodfinal);
[Vout2, ~] = runDAD2d( downsamp_nd(Yte2,sfacfinal),Xtr,drmethodfinal);
[Vout3, ~] = runDAD2d( downsamp_nd(Yte3,sfacfinal),Xtr,drmethodfinal);
[Vout4, ~] = runDAD2d( downsamp_nd(Yte4,sfacfinal),Xtr,drmethodfinal);
    

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

   
% script_visualize_jango_acrossdays_graham even changed, don't have
% run_supmethods script

figure

    subplot(4,5,5*(whichtrain-1)+1), colorData(Xtr,Ttr), title(['Training Data (D',int2str(whichtrain),')'])
    subplot(4,5,5*(whichtrain-1)+2), colorData(Vout1,Tte1), title('Alignment (D1)')
    subplot(4,5,5*(whichtrain-1)+3), colorData(Vout2,Tte2), title('Alignment (D2)')
    subplot(4,5,5*(whichtrain-1)+4), colorData(Vout3,Tte3), title('Alignment (D3)')
    subplot(4,5,5*(whichtrain-1)+5), colorData(Vout4,Tte4), title('Alignment (D4)')

%% 

whichtrain = 1; model_select =1; 
load('optimal_parameters_jango_optimize_D1.mat')
Results = apply_2Dmodelselect(Results,model_select);
Vout1 = Results.Vout1;
Vout2 = Results.Vout2;
Vout3 = Results.Vout3;
Vout4 = Results.Vout4;

%load('optimal_parameters_jango_optimize_D1.mat') ??
load('binnedData_0801.mat') % when I load binned data, it replaces the 1x1 binnedData structure with the currently loading trial
%load('binnedData_0807.mat')
%load('binnedData_0819.mat')

%% bc apply2d takes 1 min, separating sections
% function [Y,T,X] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename)
	

psamp = 0.5; % percentage of data points used for training
numIter = 1; % number os iterations (to compute stats)
whichtarg = [2,5,6,8]; % which targets to select reaches from % Graham: these are different
numD = [2,2,2,2];
numS = [4,4,4,4];

[Ytr,Ttr,Xtr] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0801.mat');
Yte1= Ytr;
Tte1=Ttr;
Xte1=Xtr;

[Yte2,Tte2,Xte2] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0807.mat');
[Yte3,Tte3,Xte3] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0819.mat');
[Yte4,Tte4,Xte4] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0901.mat');

% Yte3 = downsamp_nd(Yte3,2); in script_compare_results_across_subjects

%[Yte{1},Tte{1},Xte{1}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'~/Documents/repos/DAD/data/Jango/binnedData_0801.mat');
%[Yte{2},Tte{2},Xte{2}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'~/Documents/repos/DAD/data/Jango/binnedData_0807.mat');

% training set
[Ytr,Ttr,Xtr] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0801.mat');
	
% test set (1)
[Yte2,Tte2,Xte2] = compile_jango_neuraldata(whichtarg,numS,numD,'binnedData_0807.mat');

%% Start of visuzlize jango across days OG

% 
% R2vals_DAD(1,1) = evalR2(Vout1,Xte1(:,1:2));
% R2vals_DAD(1,2) = evalR2(Vout2,Xte2(:,1:2));
% R2vals_DAD(1,3) = evalR2(Vout3,Xte3(:,1:2));
% R2vals_DAD(1,4) = evalR2(Vout4,Xte4(:,1:2));

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
title(['SmoothKL (D1), R2 = ']) %,num2str(R2vals_DAD(1,1),2)])

subplot(3,4,6), colorData(Vout2,Tte2), 
title(['SmoothKL (D2), R2 = ']) %,num2str(R2vals_DAD(1,2),2)])

subplot(3,4,7), colorData(Vout3,Tte3), 
title(['SmoothKL (D3), R2 = ' ]) %,num2str(R2vals_DAD(1,3),2)])

subplot(3,4,8), colorData(Vout4,Tte4), 
title(['SmoothKL (D4), R2 = ']) %,num2str(R2vals_DAD(1,4),2)])

Vout1_smooth = Vout1;
Vout2_smooth = Vout2;
Vout3_smooth = Vout3;
Vout4_smooth = Vout4;

%% next model

model_select=2; % maximum R2
script_run2D_jango_applymodelselection

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
% now compare with supervised methods
Results = run_supmethods(Yte2,Xte2(:,1:2),Tte2);
Results = run_supervisedmethods(Yte2,Xte2(:,1:2),Tte2);

%%
%Results.Vout1_max = Vout1;
Results.Vout2_max = Vout2;
%Results.Vout3_max = Vout3;
%Results.Vout4_max = Vout4;

%Results.Vout1_smooth = Vout1_smooth;
Results.Vout2_smooth = Vout2_smooth;
%Results.Vout3_smooth = Vout3_smooth;
%Results.Vout4_smooth = Vout4_smooth;

Results.R2DAD_maxR2 = evalR2(Vout2_max(Results.testid,:),Xte2(Results.testid,1:2));
Results.MSEDAD_maxR2 = evalMSE(Vout2_max(Results.testid,:),Xte2(Results.testid,1:2));
Results.Pcorr_vel_DAD_maxR2 = evalCorrectTargets(Vout2_max(Results.testid,:),Xte2(Results.testid,1:2),Tte2(Results.testid));

Results.R2DAD_smooth = evalR2(Vout2_smooth(Results.testid,:),Xte2(Results.testid,1:2));
Results.MSEDAD_smooth = evalMSE(Vout2_smooth(Results.testid,:),Xte2(Results.testid,1:2));
Results.Pcorr_vel_DAD_smooth = evalCorrectTargets(Vout2_smooth(Results.testid,:),Xte2(Results.testid,1:2),Tte2(Results.testid));

%%
% jango plot (Fig 4)
figure,
colorData(Xte2,Tte2)
title('Ground Truth (D2)')

%%
figure,

subplot(3,5,1:5)
bar([[Results.R2Oracle, 1- Results.MSEOracle, Results.Pcorr_vel_Oracle]; ...
    [Results.R2Sup, 1- Results.MSESup, Results.Pcorr_vel_Sup];...
    [Results.R2KF, 1- Results.MSEKF, Results.Pcorr_vel_KF];
    [Results.R2DAD_maxR2, 1 - Results.MSEDAD_maxR2, Results.Pcorr_vel_DAD_maxR2];...
    [Results.R2DAD_smooth, 1 - Results.MSEDAD_smooth, Results.Pcorr_vel_DAD_smooth]]);
legend('R^2 Value','Decoding accuracy','Target accuracy')

subplot(3,5,[6,11])
colorData(Results.Xoracle,Tte2)
title('Oracle Solution (D2)')

subplot(3,5,[7,12])
colorData(Results.Xsup,Tte2)
title('Supervised Solution (D2)')

subplot(3,5,[8,13])
colorData(Results.Xkalman,Tte2)
title('Kalman Filter Solution (D2)')

subplot(3,5,[9,14])
colorData(Results.Vout2_max,Tte2)
title('MaxR2 Solution (D2)')

subplot(3,5,[10,15])
colorData(Results.Vout2_smooth,Tte2)
title('SmoothKL Solution (D2)')

    

