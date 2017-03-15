function ssem_New = ssem_New(T_dot,E_dot,t_Iteration,alpha)

%% Simulation of Simplified Smooth Pursuit System with DYNAMIC GAIN.
%Goal: Work in deciseconds (100 ms = 1 decisecond)
E_dot_array=zeros(1,t_Iteration);
retinal_Slip_array=zeros(1,t_Iteration);
correction_array=zeros(1,t_Iteration);
position_array=zeros(1,t_Iteration);
position=0;
t_Position=0;
t_Position_array=zeros(1,t_Iteration);
G_array = zeros(1,t_Iteration);
PE_array=zeros(1,t_Iteration);
tXE_array=zeros(1,t_Iteration);
boolean_Array = zeros(1, t_Iteration);
for i=1:t_Iteration%t_Iteration = total number of iterations
    retinal_Slip=T_dot-E_dot;%retinal slip velocity (error) = Target Velocity - Eye Velocity
    retinal_Slip_array(i)=retinal_Slip;
    position_Error=t_Position-position;%positional error
    PE_array(i)=position_Error;
    sigmoid=tanh(alpha.*retinal_Slip)./10;%hyperbolic tangent function 
    G=E_dot./T_dot;%Closed Loop Gain
    G_array(i)=G;
    k=(1-G)./G;%Gain Factor
    correction=sigmoid.*k;%correction added to E_dot
    correction_array(i)=correction;
    t_XE=-position_Error./retinal_Slip;%eye crossing time
    tXE_array(i)=t_XE;
    E_dot=E_dot+correction;
    E_dot_array(i)=E_dot;
    t_Position=t_Position+T_dot;
    t_Position_array(i)=t_Position;
    %if both target position and eye position are greater than 0 AND
    %tXE<.04s or tXE>.18s catch-up saccade occurs
    %if (gt(position,0)&&gt(t_Position,0))&&(lt(t_XE,.4) || gt(t_XE,1.8)) 
    %    position=t_Position;
    %    boolean_Array(i)=1;
    %else
    %    position=position + E_dot;
    %end
    %position_array(i)=position;
end
ts=1:t_Iteration;


subplot(3,3,1)
plot(ts,correction_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Correction (deg/s)') % y-axis label

subplot(3,3,2)
plot(ts,position_array)
hold on
plot(ts,t_Position_array)
hold off
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Position (deg)') % y-axis label

subplot(3,3,3)
plot(ts,E_dot_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Eye Velocity (deg/s)') % y-axis label

subplot(3,3,4)
plot(ts,retinal_Slip_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Retinal Slip (deg/s)') % y-axis label

subplot(3,3,5)
plot(ts,PE_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Positional Error(sec)') % y-axis label

subplot(3,3,6)
plot(ts,tXE_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Eye Crossing Time') % y-axis label

subplot(3,3,7)
plot(ts,G_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Gain') % y-axis label
