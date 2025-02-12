function temp = thermocouple_v_to_temp(v)
%THERMOCOUPLE_V_TO_TEMP Converts voltage measurements to temperature (deg C)
    temp = (v-1.25)/0.005;
end