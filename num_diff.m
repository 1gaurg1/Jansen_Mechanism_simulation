% Load or use the existing node6_data
% node6_data = [...]; % Uncomment and load if not already available

load('node6data.mat','node6data');
disp(node6data)
close all

% Columns of node6_data
node6_x1 = node6data(:, 1);
node6_y1 = node6data(:, 2);
input_angle = node6data(:, 3);

% Numerical differentiation to compute velocity components
dx_dt = diff(node6_x1) ./ diff(input_angle); % Derivative of x w.r.t input_angle
dy_dt = diff(node6_y1) ./ diff(input_angle); % Derivative of y w.r.t input_angle

% Magnitude of velocity
velocity = sqrt(dx_dt.^2 + dy_dt.^2);

vd = transpose([0, transpose(diff(sign(velocity)))]);
% Find critical points where the derivative changes sign or is close to zero
critical_indices = find(abs(vd) > 0 | abs(velocity) < 10);
    
% Critical points for node6_x, node6_y, and input_angle
critical_points = [node6_x1(critical_indices), node6_y1(critical_indices), input_angle(critical_indices)];

% Display results
disp('Critical Points:');
disp(' [node6_x, node6_y, input_angle]');
disp(critical_points);

% Plotting node6 trajectory and critical points
figure;

plot(node6_x1, node6_y1, '-b', 'LineWidth', 1.5); hold on; % Trajectory
axis([-600,100,-700,0])
%scatter(critical_points(:, 1), critical_points(:, 2), 100, 'r', 'filled'); % Critical points
xlabel('Node6 X'); ylabel('Node6 Y');
title('Node6 Trajectory with Critical Points');
grid on; legend('Trajectory');


figure;
velocity = [velocity(1),transpose(velocity)];
plot(input_angle,velocity)
xlabel('Input angle (radians)');ylabel('Velocity')
title('Velocity vs input angle')

figure;
dy_dt = [dy_dt(1),transpose(dy_dt)];
plot(input_angle,dy_dt)
xlabel('Input angle (radians)');ylabel('Y-Velocity')
title('Y-Velocity vs input angle')

figure;
dx_dt = [dx_dt(1),transpose(dx_dt)];
plot(input_angle,dx_dt)
xlabel('Input angle (radians)');ylabel('X-Velocity')
title('X-Velocity vs input angle')

%a/b value from position analysis
disp([max(node6_y1),min(node6_y1),max(node6_x1),min(node6_x1)])
disp((max(node6_y1)-min(node6_y1))/(max(node6_x1)-min(node6_x1)))

