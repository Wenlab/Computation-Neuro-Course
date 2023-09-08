% clear
clc;clear;close all;

% interface
prompt = "Change color? 1 for yes and 0 for no.\n";
is_changed = input(prompt);
if is_changed ~=0 && is_changed ~= 1
    error("Why so rebellious?")
end

% parameters
n_points = 1000;
width = 2000; % width of the window
height = 300; % height of the window
speed = 100 * 0.5; % unit: pixel per frame
size_of_point = 10;
frame_count = 0;
n_change = 1;

% set figure to grey
figure('Color', [0.5 0.5 0.5], 'Position', [100, 100, width, height]);
axis off
hold on;
axis([0 width 0 height]);
set(gca, 'Color', [0.5 0.5 0.5]);

% init positions of points uniformly
x = rand(1, n_points) * width;
y = height/n_points:height/n_points:height;
colors = [ones(1, n_points/2) zeros(1, n_points/2)];
colors = colors(randperm(n_points));

% draw init positions
plot(x(colors == 1), y(colors == 1), 'w.', 'MarkerSize', size_of_point);
plot(x(colors == 0), y(colors == 0), 'k.', 'MarkerSize', size_of_point);

% simulate moving
while ishandle(gcf)

    % update
    frame_count = frame_count + 1;

    % clear
    cla;

    % update
    x = x + speed;

    % periodic boundary condition
    x(x > width) = x(x > width) - width;

    % change color
    if is_changed && mod(frame_count, n_change) == 0
        colors = 1 - colors;
    end

    % plot
    plot(x(colors == 1), y(colors == 1), 'w.', 'MarkerSize', size_of_point);
    plot(x(colors == 0), y(colors == 0), 'k.', 'MarkerSize', size_of_point);
    drawnow;

    % pause
    pause(0.01);

end