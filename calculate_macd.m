function [macd, sig, hist] = calculate_macd(data_price_vec, fast, slow, smooth )
%MACD/SIG/HIST calculator
%   asd
[fast_vec, slow_vec] = movavg(data_price_vec, fast, slow,'e');
macd = fast_vec - slow_vec;
[sig,~] = movavg(macd,smooth,smooth,'e');
hist = macd - sig;

end

