%% apply2dmodelresults pulled out

monkey = Results.monkey;
removedir = Results.removedir;
whichtarg = setdiff(0:7,removedir);
Xtr = Results.Xtr;

numSfinal = Results.numS_minKL;
numDfinal = Results.numD_minKL;
sfacfinal = Results.sfac_minKL;
drmethodfinal = Results.drmethod_minKL;

[Yte{1},Tte{1},Xte{1}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'binnedData_0801.mat');
[Yte{2},Tte{2},Xte{2}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'binnedData_0807.mat');
[Yte{3},Tte{3},Xte{3}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'binnedData_0819.mat');
[Yte{4},Tte{4},Xte{4}] = compile_jango_neuraldata(whichtarg,numDfinal,numSfinal,'binnedData_0901.mat');
    
    Vout=cell(4,1);
    for i=1:4
        Yr = smooth_neuraldata(Yte{i},sfacfinal);
        [Vout{i}, ~] = runDAD2d(Yr,Xtr,drmethodfinal);
    end