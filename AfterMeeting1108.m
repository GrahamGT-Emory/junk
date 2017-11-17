% [Y,T,X] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename)
whichtargets = 1:8;
numSamp = 50;
numDelay = 01;
filename = 'binnedData_0801.mat';
[Y1, T1, X1] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename);
X1 = X1(:,1:2);
filename = 'binnedData_0807.mat';
[Y2, T2, X2] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename);
X2 = X2(:,1:2);
Filename = 'binnedData_0819.mat';
[Y3, T3, X3] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename);
X3 = X3(:,1:2);
filename = 'binnedData_0901.mat';
[Y4, T4, X4] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename);
X4 = X4(:,1:2);

%% just splitting into train and test by some fraction

FractionTrain = .5;
FractionTest = 1-FractionTrain;


XtoSplit = X1;
YtoSplit = Y1;
TtoSplit = T1;
SpltVal = floor(FractionTrain*length(XtoSplit));
X1_train = XtoSplit(1:SpltVal,:);
X1_test = XtoSplit(SpltVal + 1: length(XtoSplit)-1, :); % cuts off last time point to get dimension match
% min(size(X1_train)==size(X1_test))
Y1_train = YtoSplit(1:SpltVal,:);
Y1_test = YtoSplit(SpltVal + 1: length(XtoSplit)-1, :);
T1_train = TtoSplit(1:SpltVal,:);
T1_test = TtoSplit(SpltVal + 1: length(XtoSplit)-1, :);
% X1e = [X1_train; X1_test]
% min(min(X1 == X1e))
% Y1e = [Y1_train; Y1_test];
% min(min(Y1 == Y1e))
% T1e = [T1_train; T1_test];
% min(min(T1 == T1e))

XtoSplit = X2;
YtoSplit = Y2;
TtoSplit = T2;
SpltVal = floor(FractionTrain*length(XtoSplit));
X2_train = XtoSplit(1:SpltVal,:);
X2_test = XtoSplit(SpltVal + 1: length(XtoSplit), :);
% min(size(X2_train)==size(X2_test))
Y2_train = YtoSplit(1:SpltVal,:);
Y2_test = YtoSplit(SpltVal + 1: length(XtoSplit), :);
T2_train = TtoSplit(1:SpltVal,:);
T2_test = TtoSplit(SpltVal + 1: length(XtoSplit), :);
% X2e = [X2_train; X2_test];
% min(min(X2 == X2e))
% Y2e = [Y2_train; Y2_test];
% min(min(Y2 == Y2e))
% T2e = [T2_train; T2_test];
% min(min(T2 == T2e))

XtoSplit = X3;
YtoSplit = Y3;
TtoSplit = T3;
SpltVal = floor(FractionTrain*length(XtoSplit));
X3_train = XtoSplit(1:SpltVal,:);
X3_test = XtoSplit(SpltVal + 1: length(XtoSplit), :);
% min(size(X3_train)==size(X3_test))
Y3_train = YtoSplit(1:SpltVal,:);
Y3_test = YtoSplit(SpltVal + 1: length(XtoSplit), :);
T3_train = TtoSplit(1:SpltVal,:);
T3_test = TtoSplit(SpltVal + 1: length(XtoSplit), :);
% X3e = [X3_train; X3_test];
% min(min(X3 == X3e))
% Y3e = [Y3_train; Y3_test];
% min(min(Y3 == Y3e))
% T3e = [T3_train; T3_test];
% min(min(T3 == T3e))

XtoSplit = X4;
YtoSplit = Y4;
TtoSplit = T4;
SpltVal = floor(FractionTrain*length(XtoSplit));
X4_train = XtoSplit(1:SpltVal,:);
X4_test = XtoSplit(SpltVal + 1: length(XtoSplit)-1, :);
% min(size(X4_train)==size(X4_test))
Y4_train = YtoSplit(1:SpltVal,:);
Y4_test = YtoSplit(SpltVal + 1: length(XtoSplit)-1, :);
T4_train = TtoSplit(1:SpltVal,:);
T4_test = TtoSplit(SpltVal + 1: length(XtoSplit)-1, :);
% X4e = [X4_train; X4_test];
% min(min(X4 == X4e))
% Y4e = [Y4_train; Y4_test];
% min(min(Y4 == Y4e))
% T4e = [T4_train; T4_test];
% min(min(T4 == T4e))

% now have train and test, 1:4, for t, y, and x

%% s 
[R2Vals(1,:), PcorrVals(1,:), MSEVals(1,:)] = run_supervisedmethods(X1_train,X1_test,Y1_train,Y1_test,T1_train,T1_test)
[R2Vals(2,:), PcorrVals(2,:), MSEVals(2,:)] = run_supervisedmethods(X2_train,X2_test,Y2_train,Y2_test,T2_train,T2_test)
[R2Vals(3,:), PcorrVals(3,:), MSEVals(3,:)] = run_supervisedmethods(X3_train,X3_test,Y3_train,Y3_test,T3_train,T3_test)
[R2Vals(4,:), PcorrVals(4,:), MSEVals(4,:)] = run_supervisedmethods(X4_train,X4_test,Y4_train,Y4_test,T4_train,T4_test)
