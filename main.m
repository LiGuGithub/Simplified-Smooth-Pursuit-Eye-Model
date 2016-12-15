%MAIN FUNCTION
%
% Below we have several situations. We first test how smooth eye movement
% works with constant gain (This is not how the model is actual supposed to
% work, but just to see how it is we try it.) The second and third models
% are tests of how a higher target velocity (the first much higher and
% second somewhat higher) affects eye velocity. The fourth and fifth are
% the exact opposite. Finally, we want to see how variable target velocity
% can affect eye movement. 
%
%Our project is to simplify the smooth eye movement so we can show it
%mathematically. We see how the error in target velocity and eye velocity
%can be corrected in a normal simulation of the model. Later we are going
%to see how the simulation of a parkinsonian eye works in relation to
%Target Velocity.
%
%VERY TOP: SIGMOID (What is value of k and alpha)
%EYE POSITION OVER TIME
%EYE VELOCITY OVER TIME
%ERROR OF EYE MINUS TARGET OVER TIME
%Debug Variable Target Velocity (possibly create two subplots?)
%% Simplified Smooth Eye Movement with constant gain
for k=1:10
    figure(k)
    ssemkcon(20,5,20,1,k/10)%0.1<=k<=1 
end
%% Simplified Smooth Eye Movement with constant gain (eye velocity < target velocity)
for k=1:10
    figure(k+10)
    ssemkcon(5,20,20,1,k/10) % 0.1<=k<=1
end

%% Simplified Smooth Eye Pursuit Movement with Linear Correction and Constant Gain
figure (21)
ssemlinearkcon(20,5,20,1)%Oscillations, but why?
%% Simplified Smooth Eye Pursuit Movement with Linear Correction
figure(22)
ssemlinear(20,1,20,1)%Provides exponential curve because there is no tapering off of linear curve!
%% Simplified Smooth Eye Movement with Dynamic Gain (Target Velocity >> Eye Velocity)
figure(23)
ssem(20,5,20,1)%Accurrate!

%% Simplified Smooth Eye Movement with Dynamic Gain (Target Velocity > Eye Velocity)
figure(24)
ssem(10,5,20,1)%Accurrate!

%% Simplified Smooth Eye Movement with Dynamic Gain (Target Velocity VARIABLE)
figure(25)
myssemta(20,5,20,1)

