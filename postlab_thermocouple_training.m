%% postlab_thermocouple_training.m
% author: Samuel Street
% date: 2025-02-12

% use datum point where leftmost edge of plate is (37.5-~.5-.35)=~36.65 cm 
% (measured distance, estimated spacing between peltier and plate, offset
% between peltier and block)

% use datum point where bottommost edge of plate is
% (22.4+3.3+.35+~.5)=~26.55 cm (measured distance, length of orange block,
% offset between peltier and block, estimated spacing betwene peltier and
% plate)

plate_datum_offset_x = -36.65;
plate_datum_offset_y = -26.55;
orange_block_half_width = 3.3/2;

% location of the thermocouples (approximate for now, am getting this data)
tc_topright_x = 8;
tc_topright_y = 8;
tc_topleft_x = 1;
tc_topleft_y = 8;
tc_bottomleft_x = 1;
tc_bottomleft_y = 1;
tc_bottomright_x = 8;
tc_bottomright_y = 1;

% convenience functions for converting a range into datum coords
datum_x_from_rng = @(x) x - plate_datum_offset_x + orange_block_half_width;
datum_y_from_rng = @(y) plate_datum_offset_y - y - orange_block_half_width;

% NOTE: all coordinates below are provided with the origin at the
% bottom-left hand corner of the plate as viewed from the top

% the following are the redone trials
[bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
    bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = load_data("training_data/train_bl_2_ss.mat");
bottomleft_pos_x = datum_x_from_rng(37.5);
bottomleft_pos_y = datum_y_from_rng(22.5);

[bottommiddle_t,bottommiddle_ir_lsr,bottommiddle_ir_lsl,bottommiddle_ir_tsr,bottommiddle_ir_tsl, ...
    bottommiddle_tc_tr,bottommiddle_tc_br,bottommiddle_tc_bl,bottommiddle_tc_tl] = load_data("training_data/train_bm_2_ss.mat");
bottommiddle_pos_x = datum_x_from_rng(40.3);
bottommiddle_pos_y = datum_y_from_rng(22.3);

% the following are not the redone trials
[bottomright_t,bottomright_ir_lsr,bottomright_ir_lsl,bottomright_ir_tsr,bottomright_ir_tsl, ...
    bottomright_tc_tr,bottomright_tc_br,bottomright_tc_bl,bottomright_tc_tl] = load_data("training_data/train_br_ss.mat");
bottomright_pos_x = datum_x_from_rng(43.5);
bottomright_pos_y = datum_y_from_rng(22.5);

[centerleft_t,centerleft_ir_lsr,centerleft_ir_lsl,centerleft_ir_tsr,centerleft_ir_tsl, ...
    centerleft_tc_tr,centerleft_tc_br,centerleft_tc_bl,centerleft_tc_tl] = load_data("training_data/train_cl_ss.mat");
centerleft_pos_x = datum_x_from_rng(37.5);
centerleft_pos_y = datum_y_from_rng(19.5);

[centercenter_t,centercenter_ir_lsr,centercenter_ir_lsl,centercenter_ir_tsr,centercenter_ir_tsl, ...
    centercenter_tc_tr,centercenter_tc_br,centercenter_tc_bl,centercenter_tc_tl] = load_data("training_data/train_cc_ss.mat");
centercenter_pos_x = datum_x_from_rng(40.7);
centercenter_pos_y = datum_y_from_rng(19.6);

[centerright_t,centerright_ir_lsr,centerright_ir_lsl,centerright_ir_tsr,centerright_ir_tsl, ...
    centerright_tc_tr,centerright_tc_br,centerright_tc_bl,centerright_tc_tl] = load_data("training_data/train_cr_ss.mat");
centerright_pos_x = datum_x_from_rng(43.7);
centerright_pos_y = datum_y_from_rng(19);

[topleft_t,topleft_ir_lsr,topleft_ir_lsl,topleft_ir_tsr,topleft_ir_tsl, ...
    topleft_tc_tr,topleft_tc_br,topleft_tc_bl,topleft_tc_tl] = load_data("training_data/train_tl_ss.mat");
topleft_pos_x = datum_x_from_rng(37.2);
topleft_pos_y = datum_y_from_rng(16.7);

[topcenter_t,topcenter_ir_lsr,topcenter_ir_lsl,topcenter_ir_tsr,topcenter_ir_tsl, ...
    topcenter_tc_tr,topcenter_tc_br,topcenter_tc_bl,topcenter_tc_tl] = load_data("training_data/train_tc_ss.mat");
topcenter_pos_x = datum_x_from_rng(40.3);
topcenter_pos_y = datum_y_from_rng(16.3);

[topright_t,topright_ir_lsr,topright_ir_lsl,topright_ir_tsr,topright_ir_tsl, ...
    topright_tc_tr,topright_tc_br,topright_tc_bl,topright_tc_tl] = load_data("training_data/train_tr_ss.mat");
topright_pos_x = datum_x_from_rng(43.5);
topright_pos_y = datum_y_from_rng(16.3);

figure;
plot(topright_t,topright_tc_tr);
hold on
grid on
plot(topright_t,topright_tc_tl);
plot(topright_t,topright_tc_br);
plot(topright_t,topright_tc_bl);
