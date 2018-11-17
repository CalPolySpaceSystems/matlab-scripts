% CPSS Flight Data
close all;
clear all;
clc;

file = 'FlightData';
data = xlsread(file);

TEMP = data(:,6); % TEMP [K]
PRESSURE = data(:,7); % Pressure [pa]
ALTITUDE = data(:,8); % Altitude [m]
Time = data(:,5); % Time seconds


% Temperature

tMax = 60;
tHighIndices = find(TEMP>tMax);
tMin = 20;
tLowIndices = find(TEMP<tMin);

for i = 1:length(tHighIndices)
TEMP(tHighIndices(i)) = TEMP(tHighIndices(i) - 1);
end

for i = 1:length(tLowIndices)
TEMP(tLowIndices(i)) = TEMP(tLowIndices(i) - 1);
end


% Pressure

pMax = 94700;
pHighIndices = find(PRESSURE>pMax);
pMin = 86700;
pLowIndices = find(PRESSURE<pMin);

for i = 1:length(pHighIndices)
PRESSURE(pHighIndices(i)) = PRESSURE(pHighIndices(i) - 1);
end

for i = 1:length(pLowIndices)
PRESSURE(pLowIndices(i)) = PRESSURE(pLowIndices(i) - 1);
end


% Altitude

aMax = 1200;
aHighIndices = find(ALTITUDE>aMax);
aMin = 550;
aLowIndices = find(ALTITUDE<aMin);

for i = 1:length(aHighIndices)
ALTITUDE(aHighIndices(i)) = ALTITUDE(aHighIndices(i) - 1);
end

for i = 1:length(aLowIndices)
ALTITUDE(aLowIndices(i)) = ALTITUDE(aLowIndices(i) - 1);
end

% smoothing falling trend pressure
PRESSURE(2.125e4:2.14e4) = smoothdata(PRESSURE(2.125e4:2.14e4));
PRESSURE(2.14e4:2.16e4) = smoothdata(PRESSURE(2.14e4:2.16e4));
PRESSURE(2.16e4:2.18e4) = smoothdata(PRESSURE(2.16e4:2.18e4));
PRESSURE(2.18e4:2.2e4) = smoothdata(PRESSURE(2.18e4:2.2e4));
PRESSURE(2.2e4:2.22e4) = smoothdata(PRESSURE(2.2e4:2.22e4));
PRESSURE(2.22e4:2.24e4) = smoothdata(PRESSURE(2.22e4:2.24e4));

% smoothing falling trend altitude
ALTITUDE(2.125e4:2.14e4) = smoothdata(ALTITUDE(2.125e4:2.14e4));
ALTITUDE(2.14e4:2.16e4) = smoothdata(ALTITUDE(2.14e4:2.16e4));
ALTITUDE(2.16e4:2.18e4) = smoothdata(ALTITUDE(2.16e4:2.18e4));
ALTITUDE(2.18e4:2.2e4) = smoothdata(ALTITUDE(2.18e4:2.2e4));
ALTITUDE(2.2e4:2.22e4) = smoothdata(ALTITUDE(2.2e4:2.22e4));
ALTITUDE(2.22e4:2.24e4) = smoothdata(ALTITUDE(2.22e4:2.24e4));

% Figures
low = 21067;
high = 22500;
tics_per_sec = 13;
time = 1:tics_per_sec:high-low;
range = low:tics_per_sec:high;

% 1st Launch Temp
figure
plot(1:length(time),TEMP(range))
xlim([0 100])
ylim([40 60])
title('Temperature')
xlabel('Time [s]')
ylabel('Temperature [C]')

figure
plot(1:length(time),PRESSURE(range))
xlim([0 100])
ylim([88000 94700])
title('Pressure')
xlabel('Time [s]')
ylabel('Pressure [Pa]')

figure
plot(1:length(time),ALTITUDE(range) - 593)
xlim([0 100])
ylim([0 600])
title('Rocket Altitude')
xlabel('Time [s]')
ylabel('Altitude [m]')