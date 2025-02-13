function [t,ir_leftside_right,ir_leftside_left,ir_topside_right, ...
    ir_topside_left,thermo_tr,thermo_br,thermo_bl,thermo_tl] = Vol_load_data(file)
%LOAD_DATA Loads the date from the file and converts to temperature and
%distance according to the thermal models

load(file,'data','sample_rate','time');

t = time;


% does a conversion from millimeters to centimeters for convenience
ir_leftside_right = data(:,3);
ir_leftside_left = data(:,4);
ir_topside_right = data(:,1);
ir_topside_left = data(:,2);

% outputs degrees
thermo_tr = data(:,5);
thermo_br = data(:,6);
thermo_bl = data(:,7);
thermo_tl = data(:,8);

clear data sample_rate time

end