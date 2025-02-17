function [t,ir_leftside_right,ir_leftside_left,ir_topside_right, ...
    ir_topside_left,thermo_tr,thermo_br,thermo_bl,thermo_tl,...
    ir_leftside_right_volt,ir_leftside_left_volt,ir_topside_left_volt,...
    ir_topside_right_volt] = load_data(file)
%LOAD_DATA Loads the date from the file and converts to temperature and
%distance according to the thermal models

load(file,'data','sample_rate','time');

t = time;

% does a conversion from millimeters to centimeters for convenience
ir_leftside_right = ir_long_v_to_dist(data(:,3))/10;
ir_leftside_left = ir_long_v_to_dist(data(:,4))/10;
ir_topside_right = ir_med_v_to_dist(data(:,1))/10;
ir_topside_left = ir_short_v_to_dist(data(:,2))/10;

% directly gives the voltages without the fit being applied directly as
% they will be needed for ocmputation of the distance variance
ir_leftside_right_volt = data(:,3);
ir_leftside_left_volt = data(:,4);
ir_topside_right_volt = data(:,1);
ir_topside_left_volt = data(:,2);

% outputs degrees
thermo_tr = thermocouple_v_to_temp(data(:,5));
thermo_br = thermocouple_v_to_temp(data(:,6));
thermo_bl = thermocouple_v_to_temp(data(:,7));
thermo_tl = thermocouple_v_to_temp(data(:,8));

clear data sample_rate time

end