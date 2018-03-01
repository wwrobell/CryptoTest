prevDir = fileparts(pwd);
addpath(prevDir)
import_data

base_period = 10;
dim = 100;
delta_map = zeros(dim,dim);
from = 0;

tic
for n = 1:dim
    for m = 1:dim
        if n < m
            short = from + n*base_period;
            long = from + m*base_period;
            thresh = max([short;long]);
            
            [lead, lag] = movavg(price,short,long,'e');
            ss = position_lead_lag(lead, lag, price, thresh );
            [delta_map(n,m),~,~] = calculate_balance(ss,price);
        end
    end
    status = n/dim * 100;
    disp([num2str(status) '% done'])
end
toc

[maxDM,row] = max(delta_map);    % max by column
[maxDM,col] = max(maxDM); % max by row and column
opt_lead = from + row(col) * base_period
opt_lag = from + col * base_period
maxDM

figure
surfc(delta_map);
view([80 35])
lim = [-1000,maxDM];
zlim(lim)
colorbar
caxis(lim)


