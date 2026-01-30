clc;
clear;

scans = 64;           % points per scan
steps = 5;            % number of scans
xOffset = 300;        % distance between scans

s = serialport("COM5", 115200);
s.Timeout = 5;
disp("Opening: " + s.Port);
input("Press Enter to start communication...");

% data 
Data = zeros(scans, steps);

% get data from microcontroller
for step = 1:steps
    writeline(s, 's');       % sends trigger
    asdf = read(s,1,"string"); % waits for the button press of micro

    flush(s);
    
    pause(60);                % waiting for send
    
    str = read(s,1000,"string");       % read the whole line 
    
    disp(str);
    noCommma = split(str, ",");
    processed = str2double(noCommma); %process the 
    
    Data(:, step) = processed
end

interval = -270; %because the ToF sensor starts with looking at the ground
A = zeros(scans,1); 
B = zeros(scans,1); 

%conversion matrix
for i = 1:scans
    A(i) = cosd(interval);
    B(i) = sind(interval);
    interval = interval + 360 / scans;
end

D = Data';

x = repmat((0:xOffset:(xOffset*(steps - 1)))', 1, scans); 
y = repmat(A', steps, 1) .* D;  % cos * distance
z = repmat(B', steps, 1) .* D;  % sin * distance

%Plot the data
mesh(x, y, z, D); 
xlabel("X")
ylabel("Y")
zlabel("Z")



