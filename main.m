clc
close all
clearvars

import_data

%plot(diff(timestamp))   <- check consistency of data

% Lead / Lag strategy (on estimated values)
short = 81;
long = 477;

[lead,lag] = movavg(price,short,long,'e');
s = position_lead_lag(lead, lag, price, long );
[d_1,d_1p, action_1] = calculate_balance(s,price);

% MACD / SIG / HIST strategy (on estimated values)
fast = 399; 
slow = 525;
smooth = 117;

[macd, sig, hist] = calculate_macd(price, fast, slow, smooth);
s_macd = position_macd(hist, max([fast;slow;smooth]));
[d_2,d_2p, action_2] = calculate_balance(s_macd,price);

buy_vec = action_2;
buy_vec(buy_vec ~= -1) = nan;
sell_vec = action_2;
sell_vec(sell_vec ~= 1) = nan;

% PLOTS
if true
    ax(1) = subplot(2,1,1);
    plot([price,lead,lag]); grid on
    title(['Lead Lag ', newline, ' return: ',num2str(d_1,'%0.5g'),newline, num2str(d_1p,'%0.5g'),'%'])
    ax(2) = subplot(2,1,2);
    plot(s); grid on
    linkaxes(ax,'x')
    ylim([-2,2])
    title('Position')

    figure(2)
    ax(1) = subplot(2,1,1);
    plot(macd)
    hold on
    plot(sig)
    title(['MACD/SIG/HIST ', newline, ' return: ',num2str(d_2,'%0.5g'),newline, num2str(d_2p,'%0.5g'),'%'])
    stem(hist,'.')
    grid on

    ax(2) = subplot(2,1,2);
    plot(s_macd); grid on
    linkaxes(ax,'x')
    ylim([-2,2])
    title('Position')

    figure(3)
    plot(price); grid on
    hold on
    plot(price + buy_vec,'r+')
    plot(price + sell_vec,'ro')
    legend('signal','buy','sell')
    title(['Buy or sell',newline, '(MACD/SIG/HIST strategy)'])
end
