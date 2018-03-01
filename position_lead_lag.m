function s = position_lead_lag( lead, lag, data_price_vec, thresh )
%Calculate position (buy or sell)
%   Detailed explanation goes here

s = zeros(size(data_price_vec));
s(lead>lag) = 1;                         % Buy  (long)
s(lead<lag) = -1;                        % Sell (short)
s(1:thresh-1)=-1;
end

