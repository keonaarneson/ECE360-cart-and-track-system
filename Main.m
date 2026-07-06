%parameters
K_T = 7.67*10^-3; %Nm/A
R = 2.6; %ohms
L = 0.18; %mH
M_c = 0.57; %kg
M_w = 0.37; %kg
r_m = 6.35*10^-3; %m
J_1 = 3.9*10^-7; %kgm^2
J_2 = 0; %kgm^2
J_enc = 0; %kgm^2
f_1 = 0; %N*m/rad/sec
f_2 = 0; %N*m/rad/sec
f_enc = 0; %N*m/rad/sec
r_g = 3.71;
g = 9.81; %m/s^2
N_enc = 4*1024; %counts/rev
K_enc = 2.275*10^-5; %meters/count
V_max = 5; %V
T = 0.001; %s

%Part A
K_b = K_T; %Nm/A
M = M_c; %kg
J = J_1*r_g^2 + J_2;
f = f_1*r_g^2 + f_2;

a = ((R*f/r_m^2) + K_b*K_T*(r_g/r_m)^2) / (R*J/r_m^2 + R*M);
b = (K_T*r_g*1/r_m) / (R*J/(r_m^2) + R*M);

%Part B
phi = 0; %angle
K_D = R / (K_T*r_g/r_m);

%Part C
load('open_loop_cart.mat')
t_model = cart_data(1,:);
v_bd_model = cart_data(5,:);
v_bd_model = round(v_bd_model,4);
dx_model2 = cart_data(3,:);
volt_model = cart_data(6,:);
position_model = cart_data(4,:);

figure;
plot(t_model,v_bd_model);
title("Backward Difference Plot")
xlabel("Time (s)")
ylabel("Velocity (m/s)")

figure;
plot(t_model,position_model);
title("Position Plot")
xlabel("Time (s)")
ylabel("Position (m)")

figure;
v = out.dx.data;
v = v';
error = v_bd_model - v;
plot(t_model, error);
title("Backwarde difference error")
xlabel("Time (s)");
ylabel("Error (m)");

%Part D
v_0 = max(v_bd_model);

[~, idx] = min(abs(v_bd_model - v_0*0.632));
closValue = v_bd_model(idx);
T_m = t_model(find(v_bd_model == closValue));

a_model = 1/T_m(1);
b_model = v_0*a_model/(max(volt_model));

%Part E
load('Parameter_Identification_Exp_data.mat');
t_meas = cart_open_lab01(1,:);
x_meas = cart_open_lab01(2,:);
dx_meas = cart_open_lab01(3,:);
pos_meas = cart_open_lab01(4,:);
v_bd_meas = cart_open_lab01(5,:);
v_bd_meas = round(v_bd_meas,4);

v_0 = max(v_bd_meas);

[~, idx] = min(abs(v_bd_meas - v_0*0.632));
closValue = v_bd_meas(idx);
T_m = t_meas(find(v_bd_meas == closValue));

a_meas = 1/T_m(1);
b_meas = v_0*a_meas/(max(volt_model));