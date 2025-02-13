function [t,ir_leftside_right,ir_leftside_left,ir_topside_right, ...
    ir_topside_left,thermo_tr,thermo_br,thermo_bl,thermo_tl] = V2_load_data(file)
%LOAD_DATA Loads the date from the file and converts to temperature and
%distance according to the thermal models

load(file,'data','sample_rate','time');

t = time;

% does a conversion from millimeters to centimeters for convenience
ir_leftside_right = V2_ir_long_v_to_dist(data(:,3)) / 10;
ir_leftside_left = V2_ir_long_v_to_dist(data(:,4)) / 10;
ir_topside_right = V2_ir_med_v_to_dist(data(:,1)) / 10;
ir_topside_left = V2_ir_short_v_to_dist(data(:,2)) / 10;

% outputs degrees
thermo_tr = thermocouple_v_to_temp(data(:,5));
thermo_br = thermocouple_v_to_temp(data(:,6));
thermo_bl = thermocouple_v_to_temp(data(:,7));
thermo_tl = thermocouple_v_to_temp(data(:,8));

clear data sample_rate time

end