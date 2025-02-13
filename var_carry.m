function d_var = var_carry(voltages, type)
    % Compute the carried variance for the given voltages and type.
    
    if type == "LR"
        a = 0.9578;
        b = 0.002725;
        c = -0.4794; 
    elseif type == "MR"
        a = 1.629;
        b = 0.005387;
        c = 0.07977;     
    elseif type == "SR"
        a = 2.317;
        b = 0.02002;
        c = -0.1557; 
    else
        error('Invalid type. Please use "LR", "MR", or "SR".');
    end

    v_mean = mean(voltages);

    d_var = ((((-a)/ (b * v_mean^2))^2) * var(voltages))/100;
end