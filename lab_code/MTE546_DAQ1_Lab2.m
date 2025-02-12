%% MTE 546 Data Accquisition Code
% University of Waterloo MTE 546
% Written by Eugene Li Dec 2019
% Updated by Lyndon Tang Jan 2025

close all; clear all; clc;

%% Device Configuration
% If this is operating correctly the board name should appear
devices = daq.getDevices
s = daq.createSession('ni');

% Add analog inputs for each sensor being read
% 'Dev1' corresponds to the ELVIS board
% Each channel 0, 1 corresponds to the analog input on the ELVIS
addAnalogInputChannel(s, 'Dev1', 0, 'Voltage') % medium range IR (right)
addAnalogInputChannel(s, 'Dev1', 1, 'Voltage') % short range IR (left)
addAnalogInputChannel(s, 'Dev1', 2, 'Voltage') % long range IR (right)
addAnalogInputChannel(s, 'Dev1', 3, 'Voltage') % long range IR (left)
addAnalogInputChannel(s, 'Dev1', 4, 'Voltage') % top right TC (#4)
addAnalogInputChannel(s, 'Dev1', 5, 'Voltage') % bot right TC (#5)
addAnalogInputChannel(s, 'Dev1', 6, 'Voltage') % bot left TC (#6)
addAnalogInputChannel(s, 'Dev1', 7, 'Voltage') % top left TC (#7)

%% TODO: Set the sample rate
% Set the sample rate by replacing 'nan' with the desired rate in Hz
sample_rate = validate_sample_rate(15);
s.Rate = sample_rate;

% Normal Operation
% Read for a set period of time
s.DurationInSeconds = 4*60;

fprintf("Measurement Started");
[data, time] = s.startForeground;

figure;
plot(time, data(:,1:4));
title('ranges')
xlabel('Time [sec]');
ylabel('TODO: Label y-axis [units]');
legend('medium ir (right)', 'short ir (left)', 'long ir (right)', ...
    'long ir (left)');

figure
plot(time, data(:, 5:8));
title('thermos')
xlabel('Time [sec]')
legend('thermo tr', 'thermo br', 'thermo bl', 'thermo tl')


%% TODO: Save 'data', 'time' to a file
help save;
save('train_bm_2_ss', 'data', 'sample_rate', 'time')


%% Alternative Read Modes
%{
% Debugging Single-shot Read 
data = s.inputSingleScan;

% Continuous Background Read
figure;
s.DurationInSeconds = 5;
lh = addlistener(s, 'DataAvailable', @(src, event) plot(event.TimeStamps, event.Data));
s.NotifyWhenDataAvailableExceeds = 8000;
s.startBackground();
s.wait();
delete(lh);
%}

function sample_rate = validate_sample_rate(sample_rate)
assert(isequal(size(sample_rate), size(1)), 'Sample rate must be a scalar');
assert(~isnan(sample_rate), 'Sample rate was not set. Choose a sample rate');
assert((isfloat(sample_rate) && ~isinf(sample_rate)) || isinteger(sample_rate), 'Sample rate must be a number');
assert(sample_rate > 0, 'Sample rate must be positive');
fprintf('Sample rate: %.2f Hz\n', sample_rate);
end