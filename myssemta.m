function ssemta = myssemta(T_dot,E_dot,t_Iteration,alpha)

%% Simulation of Simplified Smooth Pursuit System with DYNAMIC GAIN. 

e_Dot_Array=zeros(1,t_Iteration);%array of eye velocities
t_Dot_Array=zeros(1,t_Iteration);%array of target velocities
error_Array=zeros(1,t_Iteration);%array of error of eye and target velocity
correction_Array=zeros(1,t_Iteration);%array of corrections
position_array=zeros(1,t_Iteration);%array of positions of the eye
t_Position_array=zeros(1,t_Iteration);%array of target positions
t_Position=0;
position=0;
G_array=zeros(1,t_Iteration);
for i=1:t_Iteration
    error=T_dot-E_dot;%retinal slip velocity
    error_Array(i)=error;
    %sigmoid=1./(1+exp(-(alpha.*error)));%sigmoidal error function to get correction
    sigmoid=tanh(alpha.*error);
    G=E_dot./T_dot;%Closed Loop Gain
    G_array(i)=G;
    k=(1-G)./G;%Open Loop Gain
    correction=sigmoid.*k;%correction is formed via gain multiplied by saturated linearity function
    correction_Array(i)=correction;
    E_dot=E_dot+correction;%added correction
    e_Dot_Array(i)=E_dot;
    position = position + E_dot;%position the velocity added to the previous position, each time stamp is a second
    position_array(i)=position;
    T_dot= T_dot + (-5+10.*rand(1,1));%Add random value between -5 and 5 to the target velocity.
    t_Dot_Array(i)=T_dot;
    t_Position=t_Position+T_dot;
    t_Position_array(i)=t_Position;
end
ts=1:t_Iteration;

subplot(3,2,1)
plot(ts,correction_Array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Correction (deg/s)') % y-axis label

subplot(3,2,2)
plot(ts,position_array)
hold on
plot(ts,t_Position_array)
hold off
xlabel('Time Stamp (sec)')%x-axis label
ylabel('Eye Position (deg)') % y-axis label

subplot(3,2,3)
plot(ts,e_Dot_Array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Eye Velocity (deg/s)') % y-axis label

subplot(3,2,4)
plot(ts,t_Dot_Array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Target Velocity (deg/s)') % y-axis label

subplot(3,2,5)
plot(ts,error_Array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Error (deg/s)') % y-axis label

subplot(3,2,6)
plot(ts,G_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Gain') % y-axis label


end