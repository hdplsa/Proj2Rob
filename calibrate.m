sp = init_robot('COM3');

odom = get_odom();
x = odom(1); y = odom(2); theta = odom(3);

pioneer_set_controls(sp,200,0);

pause(20);

pioneer_set_controls(sp,0,0);
