%% CPSS Telemetry Link Budget
% Patrick Chizek

close all, clear all, clc;

%% Constants
C = 299792458;  % Speed of Light (m/s)
kb = 1.381e-23;  % Boltzmann Constant (J/K) 

%% Given information
        
f = 2.4e9;          % Frequency (Hz)
Pt = 0.007;         % Transmitter Power (W)
Gt = 0;             % Half-wave Dipole Antenna Gain ()
Gr = 14;            % Ground Station Gain (dB)
Ll = 0;             % Line Loss (W)
Ts = 250;           % Noise temperature (K)
Ml = 3;             % Link Margin (dB)
e_max = 1e-6;       % Max Error
EN = 10;            % Eb/Nreq cooresponding to e_max (14)
d = 10000;          % Distance (m)

%% Question 1 - Part a

% Convert power and boltmann constant to a decibel value
Pt = 10*log10(Pt);
kb = 10*log10(kb);
Ts = 10*log10(Ts);

% Calculate free space path loss due to elevation
Ls = (20*(log10(d)+log10(f))-147.55);

% Find max data rate
R = 10.^(((-Ls)+(Pt+Gt+Gr-Ll-kb-Ts-EN-Ml))/10)