function s = position_macd( hist,thresh )
%Calculate position (buy or sell)
%   Detailed explanation goes here

s = zeros(size(hist));
s(hist>0) = 1;                         % Buy  (long)
s(hist<0) = -1;                        % Sell (short)
s(1:thresh-1)=-1;
end

