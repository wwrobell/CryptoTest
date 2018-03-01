a = timer;
set(a,'executionMode','fixedRate');
set(a,'Period',10);
set(a,'TimerFcn','monitor_bitbay');