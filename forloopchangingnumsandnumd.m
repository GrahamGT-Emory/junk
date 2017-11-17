cleanslate

% whichtargets = 1:8; % limit targets if we want

R2Values = [];
PcorrValues = [];
MSEValues = [];

% numDelay = 1;
for i = 5:20
    numSamp = i;
    for j = 0:10
        numDelay = j;
        AfterMeeting
        R2Values = [R2Values; R2Vals];
        PcorrValues = [PcorrValues; PcorrVals];
        MSEValues = [MSEValues; MSEVals];
    end
end

disp('done')

% load('forloopchangingnumsandnmd.mat')
% figure
% plot(1:length(R2Values),R2Values(:,1))
