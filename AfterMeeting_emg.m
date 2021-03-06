% [Y,T,X] = compile_jango_neuraldata(whichtargets,numSamp,numDelay,filename)
% make sure DAD repo and DR toolbox are in your matlab path, as well as the
% data that the github instructs you to download 

whichtargets = 1:8; % limit targets if we want
% 
% numSamp = 11;
% numDelay = 1;


numSamp = 5;
numDelay = 5;
% load('binnedData_0801.mat')
filename = 'binnedData_0801.mat';
[Y1, T1, X1] = compile_jango_neuraldata_emg(whichtargets,numSamp,numDelay,filename);
filename = 'binnedData_0807.mat';
[Y2, T2, X2] = compile_jango_neuraldata_emg(whichtargets,numSamp,numDelay,filename);
Filename = 'binnedData_0819.mat';
[Y3, T3, X3] = compile_jango_neuraldata_emg(whichtargets,numSamp,numDelay,filename);
filename = 'binnedData_0901.mat';
[Y4, T4, X4] = compile_jango_neuraldata_emg(whichtargets,numSamp,numDelay,filename);

% first try to filter

% need to smooth emg
i = 10:20:200;
figure
for j = 1:10
    X4env = envelope(X4,i(j),'rms');   % makes linear envelope with certain windows specified by i(j)
    subplot(3,4,j)
    plot(X4env)
end



%% just splitting into train and test by some fraction

FractionTrain = .5;
FractionTest = 1-FractionTrain;


XtoSplit = X1;
YtoSplit = Y1;
TtoSplit = T1;
SpltVal = floor(FractionTrain*length(XtoSplit));
TheEnd = length(XtoSplit);
if (SpltVal-1) < (TheEnd-(SpltVal+1))
    TheEnd = TheEnd-1;
end
X1_train = XtoSplit(1:SpltVal,:);
X1_test = XtoSplit(SpltVal + 1: TheEnd, :); % cuts off last time point to get dimension match
if min(size(X1_train)==size(X1_test)) == 0
    disp('X1 test and train not same size')
end
Y1_train = YtoSplit(1:SpltVal,:);
Y1_test = YtoSplit(SpltVal + 1: TheEnd, :);
if min(size(Y1_train)==size(Y1_test)) == 0
    disp('Y1 test and train not same size')
end

T1_train = TtoSplit(1:SpltVal,:);
T1_test = TtoSplit(SpltVal + 1: TheEnd, :);
if min(size(T1_train)==size(T1_test)) == 0
    disp('T1 test and train not same size')
end
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
TheEnd = length(XtoSplit);
if (SpltVal-1) < (TheEnd-(SpltVal+1))
    TheEnd = TheEnd-1;
end
X2_train = XtoSplit(1:SpltVal,:);
X2_test = XtoSplit(SpltVal + 1: TheEnd, :);
if min(size(X2_train)==size(X2_test)) == 0
    disp('X2 test and train not same size')
end
% min(size(X2_train)==size(X2_test))
Y2_train = YtoSplit(1:SpltVal,:);
Y2_test = YtoSplit(SpltVal + 1: TheEnd, :);
if min(size(Y2_train)==size(Y2_test)) == 0
    disp('Y2 test and train not same size')
end
T2_train = TtoSplit(1:SpltVal,:);
T2_test = TtoSplit(SpltVal + 1: TheEnd, :);
if min(size(T2_train)==size(T2_test)) == 0
    disp('T2 test and train not same size')
end
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
TheEnd = length(XtoSplit);
if (SpltVal-1) < (TheEnd-(SpltVal+1))
    TheEnd = TheEnd-1;
end
X3_train = XtoSplit(1:SpltVal,:);
X3_test = XtoSplit(SpltVal + 1: TheEnd, :);

if min(size(X3_train)==size(X3_test)) == 0
    disp('X3 test and train not same size')
end
% min(size(X3_train)==size(X3_test))
Y3_train = YtoSplit(1:SpltVal,:);
Y3_test = YtoSplit(SpltVal + 1: TheEnd, :);
if min(size(Y3_train)==size(Y3_test)) == 0
    disp('Y3 test and train not same size')
end
T3_train = TtoSplit(1:SpltVal,:);
T3_test = TtoSplit(SpltVal + 1: TheEnd, :);
if min(size(T3_train)==size(T3_test)) == 0
    disp('T3 test and train not same size')
end

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
TheEnd = length(XtoSplit);
if (SpltVal-1) < (TheEnd-(SpltVal+1))
    TheEnd = TheEnd-1;
end
X4_train = XtoSplit(1:SpltVal,:);
X4_test = XtoSplit(SpltVal + 1: TheEnd, :);
if min(size(X4_train)==size(X4_test)) == 0
    disp('X4 test and train not same size')
end
% min(size(X4_train)==size(X4_test))
Y4_train = YtoSplit(1:SpltVal,:);
Y4_test = YtoSplit(SpltVal + 1: TheEnd, :);
if min(size(Y4_train)==size(Y4_test)) == 0
    disp('Y4 test and train not same size')
end
T4_train = TtoSplit(1:SpltVal,:);
T4_test = TtoSplit(SpltVal + 1: TheEnd, :);
if min(size(T4_train)==size(T4_test)) == 0
    disp('T4 test and train not same size')
end
% X4e = [X4_train; X4_test];
% min(min(X4 == X4e))
% Y4e = [Y4_train; Y4_test];
% min(min(Y4 == Y4e))
% T4e = [T4_train; T4_test];
% min(min(T4 == T4e))

% now have train and test, 1:4, for t, y, and x

%% s 
[R2Vals(1,:), PcorrVals(1,:), MSEVals(1,:)] = run_supervisedmethods(X1_train,X1_test,Y1_train,Y1_test,T1_train,T1_test);
% [R2Vals(2,:), PcorrVals(2,:), MSEVals(2,:)] = run_supervisedmethods(X2_train,X2_test,Y2_train,Y2_test,T2_train,T2_test)
% [R2Vals(3,:), PcorrVals(3,:), MSEVals(3,:)] = run_supervisedmethods(X3_train,X3_test,Y3_train,Y3_test,T3_train,T3_test)
% [R2Vals(4,:), PcorrVals(4,:), MSEVals(4,:)] = run_supervisedmethods(X4_train,X4_test,Y4_train,Y4_test,T4_train,T4_test)
