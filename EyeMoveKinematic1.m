% eye movement kinematics.
% In this script, we consider a Normal Control (NC) model and a position 
% correction 
% disorder (PD). This script is based on a model which only considers possible 
% kinematics of "position" correction, and "ignores" any kinematics 
% and dynamics of "velocity". We try different position compensation which
% can be done with saccades. As you will see in below, this is the most
% simple code to begin with.

% In the next practice code, we further get to the kinematics of the eye
% velocity. For that, please refer to the attached PDF which considers both
% position and velocity and their derivatives (we can consider it a simple 
% dynamical system from White's work).

% Let's start with the cast of characters:

clear all;

% clear all of the past variables, good to have this before running the
% code not to have interference with the past saved variables

close all;
% close all of the past figures to have a fresh clean screen


Th1 = 0.15;
% this is the amount of offset (unitless for now, we can assign a unit to
% these all later) threshold that activates the corrective saccade.
% As you see, our corrective saccade is done kinematically.

Target = 0:0.01:1;
% The above lays out the uniform movement of target

Eye = 0:0.02:2;
% This lays out the uniform movement of the eye. Please note that the the
% step size and extent are twice of the Target, generating a scenario as if
% the eyes' velocity is twice of the target. As you see, at this point,
% we purely ignored the dynamics which generates the pursuit velocity and 
% only went for a mismatched eye/target velocity kinematics:


t = 0:0.01:1;
% We need time stamp for each position. Hence, let's create a time array. 

Sz1 = size(t,2); 
% use MATLAB help to get an idea why we did the following and how we use it
% later down the code.


% (please see below) target over time
% Look up MATLAB help to see the usage of plot and subplot. As you see,
% this will help us to have plots side by side.

figure(1)
subplot(4,2,1)
plot(t, Target);
ylim([0 2])
title('Target position vs. time')

% eye position over time

subplot(4,2,2)
% as you see, we generated a constant eye velocity. See it through the
% following plot. 
plot(t, Eye);
title('Eye  position vs. time');

% eye-target relative position
% this is a practice plot to show the kinematics of eye-target offset.

subplot(4,2,3)
% please note the subtraction in below:
plot(t, Eye-Target);

title('Relatie eye-target offset');
ylim([0 2])

% Please see in below we consider a kinematic approach to correct the eye
% position assuming its constant ongoing pursuit velocity (we get to a bit 
% more sophisticated eye movement kinematics and right after, dynamics)

% Correcting eye position in a normal control (NC).

subplot(4,2,4)

% the simple correction method in below repetitively checks the eye-target
% offset and if that exceeds a threshold that we set, it resets the eye
% back on target.

% Please tweak around Th1, eye and stimulus velocity to get hands on the
% kinematics. 

% Kinematically, this could be one of the key step to quantify the
% difference between OCD and Schizophrenia. 

% Nikos and Aggeliki, knowing
% that you have clear idea/ hypothesis on the difference between OCD and
% Schizophrenia on a dynamical basis, here could be a good point to 
% consider quantifying the kinematics first. Please also see further below. 

for i = 1:Sz1 % find above Sz1
    
    if abs(Eye(i)-Target(i)) > Th1
        
        Eye(i+1:end) = Eye(i+1:end) + Target(i) - Eye(i);
        
    end;
    
end;

% let's look on the mixed saccade (of course currently our saccade is 
% hand-made) pursuit pattern:

plot(t, Eye);
ylim([0 2]);
title('Pursuit-Saccade in NC');

% Eye-target relative position in NC given the above kinematics

subplot(4,2,5)
plot(t, Eye-Target);
title('corrected Eye-target NC');
ylim([0 1]);

%%%%%%%%%
% now let's introduce malfunctional saccades/position correction:

Th1 = 0.15;
Target = 0:0.01:1;
% note I made the eyes fall behind (mimicking Parkinson's disease, 
% you can change it and tweak around, for example when eyes get ahead of 
% moving target)

Eye = 0:0.005:0.5;
t = 0:0.01:1;
Sz1 = size(t,2); 

% The same game, but please note that the correction is malfunctional:

subplot(4,2,6)

for i = 1:Sz1
    
    if abs(Eye(i)-Target(i)) > Th1
        % in here, the correction is random either in amplitude, or in
        % direction of correction, increasing or decreasing eye-target
        % offset. This is something that we can see in Parkinson's disease.
        % Please tweak around 0.30 to get an intuitive sense. 
        
        Eye(i+1:end) = Eye(i+1:end) + 0.30.*(rand-0.5);%Target(i) - Eye(i)
        
    end;
    
end;


plot(t, Eye);
ylim([0 2])
title('Eye position vs. time in malfunctional correction');
 
subplot(4,2,7)
plot(t, Eye-Target);
title('Eye-target offset in malfunctional eye position correction');

% Now we are left with a few kinematics adventure:

% a) fixation with random drifts and precise correction (a1), 
%    (a2) and malfunctional correction.
% 
% b) getting subtler about the velocity dynamics. For this please find
% attached an assignment which I shared with students in a workshop
% in Slovakia last summer. We can consider this a starting point. Given
% Nikos's hypothesis and Aggeliki's experience working on OCD and
% Schizophrenia, we can initiate a basic code and develop it step by step 
% over time. Looking forward to our upcoming exchanges!








