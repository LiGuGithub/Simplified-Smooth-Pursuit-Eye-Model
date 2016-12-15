function ssemkcon = ssemkcon(T_dot,E_dot,t_Iteration,alpha,k)

%% Simulation of Simplified Smooth Pursuit System with CONSTANT GAIN. 
E_dot_array=zeros(1,t_Iteration);
error_array=zeros(1,t_Iteration);
correction_array=zeros(1,t_Iteration);
position_array=zeros(1,t_Iteration);
position=0;
t_Position=0;
t_Position_array=zeros(1,t_Iteration);
for i=1:t_Iteration%t_Iteration=Total Number of Iteration
    error=T_dot-E_dot;%Retinal Slip Velocity (Error) = Target Velocity - Eye Velocity
    error_array(i)=error;
    %plot error
    sigmoid=tanh(alpha.*error);%Sigmoidal Function to determine correction
    correction=sigmoid.*k;%multiplicative correction
    correction_array(i)=correction;
    E_dot=E_dot+correction;%correction of eye velocity
    E_dot_array(i)=E_dot;%add eye velocity at second i to array.
    position= position+E_dot;
    position_array(i)=position;
    t_Position=t_Position+T_dot;
    t_Position_array(i)=t_Position;
end
ts=1:t_Iteration;
subplot(4,1,1)
plot(ts,correction_array)

xlabel('Time Stamp (sec)') % x-axis label
ylabel('Correction (deg/s)') % y-axis label

subplot(4,1,2)
plot(ts,position_array)
hold on
plot(ts,t_Position_array)
hold off
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Position (deg)') % y-axis label

subplot(4,1,3)
plot(ts,E_dot_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Eye Velocity (deg/s)') % y-axis label

subplot(4,1,4)
plot(ts,error_array)
xlabel('Time Stamp (sec)') % x-axis label
ylabel('Error (deg/s)') % y-axis label

end

