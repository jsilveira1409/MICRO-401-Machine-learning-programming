function [] = plot_bitcoin_comparison(data, Yproj, legend2)
%PLOT_BITCOIN_COMPARISON Summary of this function goes here
%   Detailed explanation goes here
bitcoin_price = data(1,:);
plot(bitcoin_price, 'r')
hold on
plot(Yproj(1,:), 'b')

xlabel("time")
legend("bitcoin price",legend2)
end

