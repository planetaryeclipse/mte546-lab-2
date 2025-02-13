clc
clear
close all

plate_datum_offset_x = 36.65;
plate_datum_offset_y = 26.55;
orange_block_half_width = 3.3/2;

% convenience functions for converting a range into datum coords
datum_x_from_rng = @(x) x - plate_datum_offset_x + orange_block_half_width;
datum_y_from_rng = @(y) plate_datum_offset_y - y - orange_block_half_width;


% bottom left case

[bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
    bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = load_data("training_data/train_bl_2_ss.mat");
bottomleft_pos = [datum_x_from_rng(37.5) datum_y_from_rng(22.5)]';




