prevDir = fileparts(pwd);
addpath(prevDir)
import_data

base_period = 200; %~10 min
from = 0;
smooth = 21;

dim = 100;
delta_map = zeros(dim,dim);
tic
for n = 1:dim
    for m = 1:dim
        if n < m
            short = from+ n*base_period;
            long = from+ m*base_period;

            thresh = max([short;long]) + smooth;
            [~,~,hist] = calculate_macd(price, short, long, smooth);
            ss = position_macd(hist, thresh);
            [delta_map(n,m),~,~] = calculate_balance(ss, price);
        end
    end
    status = n/dim * 100;
    disp([num2str(status) '% done'])
end
toc

figure
surfc(delta_map);
view([80 35])
colorbar

[maxDM,row] = max(delta_map);    % max by column
[maxDM,col] = max(maxDM); % max by row and column

%podejscie MACD/SIG/HIST
fast = row(col) * base_period
slow = col * base_period
maxDM