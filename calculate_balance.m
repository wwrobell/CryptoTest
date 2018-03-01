function [delta, d_p, zer_action] = calculate_balance( s, data_price_vec)
%Account balance calculator

%ignore (x - 1) first samples
x = 6;
position = s(x:end);
prices = data_price_vec(x:end);
                
%taker_fee = 0.0043; %bitbay fee
%maker_fee = 0.0030; %bitbay_fee

taker_fee = 0.002; %bitfinex fee
maker_fee = 0.001; %bitfinex fee

action = -[0; diff(position)]/2;

% first transaction must be 'buy' !
first_action_idx = find(action,1,'first'); 
first_action = action(first_action_idx);
if first_action == 1
   action(first_action_idx) = 0;
end

% last transaction must be 'sell' !
last_action = action(find(action,1,'last')); %ostatnia transakcja (1 = sprzeda¿)
if last_action == -1
    action(end) = 1;
end

first_buy_idx = find(action == - 1,1,'first');
first_buy_price = prices(first_buy_idx);

fees = sum(abs(taker_fee*prices.*action));
delta = sum(prices.*action) - fees;

zer_action = [zeros(x-1,1); action];
d_p = delta/first_buy_price * 100;
end

