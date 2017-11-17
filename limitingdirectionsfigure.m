% limitingdirectionsfigure


whichtargets = 1:8;
AfterMeeting
R2_1 = R2Vals;
whichtargets = 1:2:8;
AfterMeeting
R2_2 = R2Vals;

whichtargets = 2:2:8;
AfterMeeting
R2_3 = R2Vals;

%% plot1:8
figure
subplot(1,3,1)
plot(R2_1(2), 'o'), hold on 
plot(R2_1(4), 'o'), hold on
plot(R2_1(6), 'o'), ylim([0 1]), legend('oracle', 'kalman', 'sup')
title('All directions')

%% plot1:2:8
subplot(1,3,2)
plot(R2_2(2), 'o'), hold on 
plot(R2_2(4), 'o'), hold on
plot(R2_2(6), 'o'), ylim([0 1]), legend('oracle', 'kalman', 'sup')
title('All directions') 

title('Forward, back, left, right')
%% plot2:2:8
subplot(1,3,3)
plot(R2_3(2), 'o'), hold on 
plot(R2_3(4), 'o'), hold on
plot(R2_3(6), 'o'), ylim([0 1]), legend('oracle', 'kalman', 'sup')
title('All directions')

title('diagonals')