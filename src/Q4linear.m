dates = 1:7; % 6月23日到6月30日的日期
prices = [1
    2
    3
    4
    5
    6
    7];

% 创建日期矩阵，包括未来一周的日期
future_dates = 8:8; % 假设6月31日到7月6日的日期

% 使用线性回归模型进行预测
coefficients = polyfit(dates, prices, 1); 
predicted_prices = polyval(coefficients, future_dates);

disp('预测的批发价格：');
disp(predicted_prices);

% 可以将预测结果可视化
plot(dates, prices, 'o', future_dates, predicted_prices, '-');
xlabel('日期');
ylabel('批发价格');
legend('实际价格', '预测价格');
title('蔬菜批发价格预测');
