%% Define configuration variables
PRESSURE = 1;
GPS = 2;
IMU = 3;
BAROMETER = 4;

pressure_taps_Spec = '%C%C%f%f%f%f%f%f%f%[^\n\r]';
gps_Spec = '%C%C%f%f%f%f%[^\n\r]';
imu_Spec = '%C%C%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
barometer_Spec = '%C%C%f%f%f%f%[^\n\r]';

pressure_taps_columns = {'TARGET','PACKET','CH1','CH2','CH3','CH4','CH5','CH6','RTC'};
gps_columns = {'TARGET','PACKET','TIME', 'LAT', 'LON', 'RTC'};
imu_columns = {'TARGET','PACKET','TEMP','ACCEL_X', 'ACCEL_Y', 'ACCEL_Z', 'GYRO_X', 'GYRO_Y', 'GYRO_Z','MAG_X', 'MAG_Y', 'MAG_Z','RTC'};
barometer_columns = {'TARGET','PACKET','TEMP', 'PRESSURE', 'ALTITUDE','RTC'};

output_dir = 'D:\COSMOS\COSMOS-Telemetry\outputs\logs\';
output_file_extensions = "*.txt";

%% Get user input category and file
prompt = sprintf('\n\t(1) Pressure Taps\n\t(2) GPS\n\t(3) IMU\n\t(4) Barometer\nEnter number of data type: ');
log_type = input(prompt);

switch (log_type)
    case 1
        data_type = PRESSURE;
    case 2
        data_type = GPS;
    case 3
        data_type = IMU;
    case 4
        data_type = BAROMETER;
    otherwise
        error("Error, invalid data type");
end

%% Initialize variables.
[baseName, folder] = uigetfile({'*.txt'});
filename = fullfile(folder,baseName);
if filename == 0
    error("Invalid file");
end

delimiter = '\t';
startRow = 3;

%% Format for each line of text:
switch (data_type)
    case 1
        formatSpec = pressure_taps_Spec;
        columnNames = pressure_taps_columns;
    case 2
        formatSpec = gps_Spec;
        columnNames = gps_columns;
    case 3
        formatSpec = imu_Spec;
        columnNames = imu_columns;
    case 4
        formatSpec = barometer_Spec;
        columnNames = barometer_columns;
    otherwise
        error("Format spec could not be found");
end

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
tlm = table(dataArray{1:end-1}, 'VariableNames', columnNames);

switch (data_type)
    case 1
        pressure_taps = tlm;
    case 2
        gps = tlm;
    case 3
        imu = tlm;
    case 4
        barometer = tlm;
    otherwise
        error("Error in establishing data type, this shouldn't happen.");
end

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
clearvars PRESSURE GPS IMU BAROMETER;
clearvars pressure_taps_Spec gps_Spec imu_Spec barometer_Spec;
clearvars pressure_taps_columns gps_columns imu_columns barometer_columns;
clearvars baseName columnNames data_type folder log_type output_dir output_file_extensions prompt
clearvars tlm
