% 预估的批发价平均值
wholesale_prices = [
    3.5025
2.66625
1.953387097
1.453362832
3.402571429
15.6
1.3
3.25
4.082258065
3.8775
6.984931507
4.34
3.737021277
9.635294118
4.134897959
4.606
3.190740741
3.222735849
1.566666667
2.5314
4.131969697
4.757260274
8.241428571
2.325583333
2.842222222
5.741666667
3.57579646
4.34
2.869530201
2.330139535
7.772964824
8.945490196
12.97323077
2.45877551
7.481653543
3.32835443
12.27466667
3.210666667
2.83
3.367573529
2.149
1.523417722
11.55
13.46478261
5.588333333
18
10.734
9.168695652
16.06666667
];

% 预估的销售平均价格
retail_prices = [
    5.7
3.6125
2.748387097
1.879646018
5.03
24
2.425
4.5
6
6.133333333
12
9
6
14
5.510204082
6
5.333333333
5.332075472
3.366666667
4.792
8
6.54109589
12.51428571
3.805
5.2
9.2
4.461504425
7.2
4.159060403
3.773953488
12.4080402
12.8
18.89230769
4.72244898
11.29133858
4.92278481
18.98666667
5.493333333
4.3
5.2
5.769333333
2.586075949
13.19298246
15.49565217
9.2
20.09090909
14.4
14
26
];

% 每日补货量
daily_replenishment = [
    1
1
1
1
1
0.183914773
1
1
0.604096774
0.62025
0.404123288
0.512
0.541276596
0.401176471
1
0.44385
0.38945679
0.391830189
1
0.44959
0.409530303
1
0.467
0.520508333
0.381177778
0.324527778
1
0.392153846
1
0.432916279
2.025892663
1.919273725
0.219230769
1
0.377141732
1
0.2434
1
1
0.366301471
1
1
0.627984035
0.564913043
0.921961667
1.106272727
1.678980444
2.568347391
4.038208333
];

% 约束条件
min_display_quantity = 2.5; % 最小陈列量
min_selected_items = 27; % 选出的最小单品数量
max_selected_items = 33; % 选出的最大单品数量

% 粒子群算法参数
num_particles = 50; % 粒子数量
num_iterations = 100; % 迭代次数
w = 0.5; % 惯性权重
c1 = 1; % 个体认知因子
c2 = 1; % 社会认知因子

% 初始化粒子群
particle_position = rand(num_particles, 50); % 随机初始化粒子位置
particle_velocity = zeros(num_particles, 50); % 初始速度为0
particle_best_position = particle_position; % 记录粒子的最佳位置
global_best_position = particle_best_position(1, :); % 记录全局最佳位置

% 计算初始适应度
for i = 1:num_particles
    % 计算适应度，这里需要根据你的目标函数编写
    % 利润 = 每个单品的补货总量 * (每个单品的定价 - 每个单品的批发价格)
    % 这里需要将目标函数适应度计算代码替换成你的实际计算逻辑
    profit = sum(particle_position(i, :) .* (retail_prices - wholesale_prices));
    
   % 更新粒子最佳位置和全局最佳位置
particle_best_position(i, :) = max(particle_best_position(i, :), profit);
global_best_position = max(global_best_position, profit);
end
% 开始迭代
for iteration = 1:num_iterations
    for i = 1:num_particles
        % 更新粒子速度和位置
        r1 = rand(1, 50);
        r2 = rand(1, 50);
        particle_velocity(i, :) = w * particle_velocity(i, :) + ...
            c1 * r1 .* (particle_best_position(i, :) - particle_position(i, :)) + ...
            c2 * r2 .* (global_best_position - particle_position(i, :));
        particle_position(i, :) = particle_position(i, :) + particle_velocity(i, :);
        
        % 约束条件处理
        % 这里需要根据你的约束条件编写处理代码
        
        % 计算适应度
        profit = sum(particle_position(i, :) .* (retail_prices - wholesale_prices));
        
        % 更新粒子最佳位置和全局最佳位置
        if profit > particle_best_position(i)
            particle_best_position(i, :) = profit;
        end
        if profit > global_best_position
            global_best_position = profit;
        end
    end
end

% 输出结果
disp(['最终总利润最大值: ', num2str(global_best_position)]);
disp(['最优解: ', num2str(particle_position(1, :))]);