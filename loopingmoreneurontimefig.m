%% Changing amount of time:
SpltVals = [75 100 250 500 750 1000 2000]% [69 128 256 512 2024];
R2Values = [];
for i = 1:length(SpltVals)
    SpltVal = SpltVals(i);
    moreneurontimefigure
    R2Values = [R2Values;R2Vals]
    disp('done with cycle')
end

% R2Vals = [ [evalR2(Xr,Xtrain), evalR2(Xr2,Xtest)], [evalR2(Xkf',Xtrain), evalR2(Xkf2',Xtest)], [evalR2(Xsup,Xtrain), evalR2(Xsup2,Xtest)] ];
R2Oracle = R2Values(:,2);
R2K = R2Values(:,4);
R2Sup= R2Values(:,6); R2Sup(1) = 0;
figure
plot(SpltVals(1:6),R2Oracle, 'o'), hold on, plot(SpltVals(1:6),R2K, 'o'), hold on, plot(SpltVals(1:6),R2Sup, 'o'), ylabel('R^2 Value'), xlabel('number time buckets'), legend('oracle', 'kalman', 'sup')

%% now changing n neurons 

nneuron = [8 16 32 64];
nneuron = nneuron/2;
R2Values_neurons = [];
for i = 1:length(nneuron)
    nneurons = nneuron(i);
    SpltVal = nneurons;
    TheEnd = 2*SpltVal;
    moreneuronfigurenew
    R2Values_neurons = [R2Values_neurons; R2Vals]
end
R2Oracle = R2Values_neurons(:,2);
R2K = R2Values_neurons(:,4);
R2Sup= R2Values_neurons(:,6); 
figure
plot(nneuron,R2Oracle, 'o'), hold on, plot(nneuron,R2K, 'o'), hold on, plot(nneuron,R2Sup, 'o'), ylabel('R^2 Value'), xlabel('number time buckets'), legend('oracle', 'kalman', 'sup')
