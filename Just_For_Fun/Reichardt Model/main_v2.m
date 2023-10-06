%% prepare

% clear
clc; clear; close all;

% interface
prompt = "Change color? 1 for yes and 0 for no.\n";
is_changed = input(prompt);
if is_changed ~= 0 && is_changed ~= 1
    error("Why so rebellious?")
end

% parameters
width = 2000; % width of the window
height = 300; % height of the window
speed = 0; % unit: pixel per frame
size_of_point = 10;
frame_count = 0;

% set figure to grey
figure('Color', [0.5 0.5 0.5], 'Position', [100, 100, width, height]);
axis off
hold on;
axis([0 width 0 height]);
set(gca, 'Color', [0.5 0.5 0.5]);

%% init

method = "random_x_y";

switch method
    case "random_x_y"
        n_points = 1000;
        x = rand(1, n_points) * width;
        y = rand(1, n_points) * height;
        colors = [ones(1, n_points/2) zeros(1, n_points/2)];
end

% draw init positions
plot(x(colors == 1), y(colors == 1), 'w.', 'MarkerSize', size_of_point);
plot(x(colors == 0), y(colors == 0), 'k.', 'MarkerSize', size_of_point);

%% simulate

while ishandle(gcf)

    % update
    frame_count = frame_count + 1;

    % clear for moving
    cla;

    % Change color or not, based on user choice
    if is_changed
        colors = 1 - colors;
    end

    % update
    x = x + speed;

    % periodic boundary condition
    x(x > width) = x(x > width) - width;

    % plot
    plot(x(colors == 1), y(colors == 1), 'w.', 'MarkerSize', size_of_point);
    plot(x(colors == 0), y(colors == 0), 'k.', 'MarkerSize', size_of_point);
    drawnow;

    % pause
    % pause(0.5); % Adjust the pause time if needed

    % clear for disappearance
    cla;

    % Reinitialize random positions for reappearance
    x = rand(1, n_points) * width;
    y = rand(1, n_points) * height;

    % pause for disappearance effect
    % pause(0.5); % Adjust the pause time if needed
end
