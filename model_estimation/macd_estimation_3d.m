%MACD test
prevDir = fileparts(pwd);
addpath(prevDir)
import_data

base_period = 1;
dim = 20;
delta_map = zeros(dim,dim,dim);
from = 120;
tic
for n = 1:dim
    for m = 1:dim
        for l = 1:dim
            if n < m
                short = from+ n*base_period;
                long = from+ m*base_period;
                smooth = from+ l*base_period;
                
                thresh=max([short;long]) + smooth;
                [~,~,hist] = calculate_macd(price,short, long, smooth);
                ss = position_macd(hist,thresh);
                [delta_map(n,m,l),~,~] = calculate_balance(ss, price);
            end
        end
    end
    status = n/dim * 100;
    disp([num2str(status) '% done'])
end
toc

% figure
% surfc(delta_map);
% view([80 35])
% colorbar

[MAX,I] = max(delta_map(:));
dims = size(delta_map);
smax = cell(size(dims));
[smax{:}] = ind2sub(dims,I);

opt_fast =from + smax{1} * base_period
opt_slow =from + smax{2} * base_period
opt_smooth =from + smax{3} * base_period
MAX