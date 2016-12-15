function ssemlinear = ssemlinear(T_dot,E_dot,t_Iteration,alpha)
%% Simulation of Simplified Smooth Pursuit System with DYNAMIC GAIN and LINEAR CORRECTION. 
E_dot_array=zeros(1,t_Iteration);
error_array=zeros(1,t_Iteration);
correction_array=zeros(1,t_Iteration);
position_array=zeros(1,t_Iteration);
position=0;
t_Position=0;
t_Position_array=zeros(1,t_Iteration);
G_array=zeros(1,t_Iteration);
for i=1:t_Iteration%t_Iteration = total number of iterations
    error=T_dot-E_dot;%retinal slip velocity (error) = Target Velocity - Eye Velocity
    error_array(i)=error;
    linear=alpha.*error;%linear function instead of saturating nonlinearity
    G=E_dot./T_dot;%Closed Loop Gain
    G_array(i)=G;
    k=(1-G)./G;%Open Loop Gain
    correction=linear.*k;%correction added to E_dot
    correction_array(i)=correction;
    E_dot=E_dot+correction;
    E_dot_array(i)=E_dot;
    t_Position=t_Position+T_dot;
    t_Position_array(i)=t_Position;
    position = position + E_dot;
    position_array(i)=position;
end
ts=1:t_Iteration;
subplot(5,1,1)
plot(ts,correction_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Correction (deg/s)') % y-axis label

subplot(4,1,2)
plot(5,position_array)
hold on
plot(ts,t_Position_array)
hold off
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Position (deg)') % y-axis label

subplot(5,1,3)
plot(ts,E_dot_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Eye Velocity (deg/s)') % y-axis label

subplot(5,1,4)
plot(ts,error_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Error (deg/s)') % y-axis label

subplot(5,1,5)
plot(ts,G_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Gain') % y-axis label

end
