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

datum_x_from_rng = @(x) x - plate_datum_offset_x + orange_block_half_width;
datum_y_from_rng = @(y) plate_datum_offset_y - y - orange_block_half_width;

% NOTE: all coordinates below are provided with the origin at the
% bottom-left hand corner of the plate as viewed from the top

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
