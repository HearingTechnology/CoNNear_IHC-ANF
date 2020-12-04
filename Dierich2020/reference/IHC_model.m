function [Vm,MET,K74,Kf,K18,K11,K12,Kn]=IHC_model(mu,fs,block_list)

%    Inner hair cell model including 6 distinct basolateral K+ channels

%    Script supplementing:
%    "Dierich et al., Optimized Tuning of Auditory Inner Hair Cells to Encode Complex Sound through 
%    Synergistic Activity of Six Independent K+ Current Entities", Cell Reports (2020) 32, 107869
%    https://doi.org/10.1016/j.celrep.2020.107869
%    For fair use only.


% inputs:
% mu - signal representing stereocilia vibration
% fs - sampling frequency
% block_list - list of currents to be made voltage independent (see
% example)
% {'Kf','Kn','K11','K12',K74','K18'}
%Kf - BK fast K+ channels
%K74 -> Kv7.4 (Ik,s)
%Kn -> Kv7.4 (Ik,n)
%K11 -> Kv11.1
%K18 -> Kv1.8
%K12 -> Kv12.1

%outputs
% Vm - membrane potential
% MET - MET current
% K74... Kn - the current flowing in the various K+ channels

if nargin<3
block_list={};
end
filename='IHC_param';
run(filename)
dt=1/fs;

% coefficient for including activation time constants. 
% Numerical calculations based on the impulse invariance method
% https://en.wikipedia.org/wiki/Impulse_invariance
alphakf=exp(-dt/tauKf);
alphak18=exp(-dt/tauK18);
alphakn=exp(-dt/tauKn);
alphak11=exp(-dt/tauK11);
alphak12=exp(-dt/tauK12);
alphaMet=exp(-dt/tauMet);


% initial parameters
    V=-53e-3; %start with values obtained using a close approximation of resting potential
    mkf=1/(1+exp(-(V-Xkf)/SKf));
    mk74=1/(1+exp(-(V-Xk74)/SK74));
    mkn=1/(1+exp(-(V-Xkn)/SKn));
    mk11=1/(1+exp(-(V-Xk11)/SK11));
    mk18=1/(1+exp(-(V-Xk18)/SK18));
    mk12=1/(1+exp(-(V-Xk12)/SK12));

Vm=zeros(size(mu));
MET=zeros(size(mu));
K74=zeros(size(mu));
Kn=zeros(size(mu));
K11=zeros(size(mu));
K18=zeros(size(mu));
K12=zeros(size(mu));
Kf=zeros(size(mu));
mu=[zeros(100e-3*fs,1)' mu]; %input (cilia vibrations) padded with 100 ms of silence
mtIn=1./(1+exp((x0-mu)./s1).*(1+exp((x0-mu)./s0)));
mt=1./(1+exp((x0-0)./s1).*(1+exp((x0-0)./s0)));

%   run 100 ms of silence before running the stimulus, 
%   to be sure to start with the model at Equilibrium 
for i=1:100e-3*fs 
    mt=alphaMet*mt+(1-alphaMet)*mtIn(i); %met activation
    Imet=(Gmet*mt)*(V-EP);  %met current
    Ileak=Gleak*(V); %Leak current (0 in this model)
    mkf=1/(1+exp(-(V-Xkf)/SKf))*(1-alphakf)+mkf*alphakf; %activation of the channels
    mk74=1/(1+exp(-(V-Xk74)/SK74))*(1-alphakn)+mk74*alphakn;
    mkn=1/(1+exp(-(V-Xkn)/SKn))*(1-alphakn)+mkn*alphakn;
    mk11=1/(1+exp(-(V-Xk11)/SK11))*(1-alphak11)+mk11*alphak11;
    mk18=1/(1+exp(-(V-Xk18)/SK18))*(1-alphak18)+mk18*alphak18;
    mk12=1/(1+exp(-(V-Xk12)/SK12))*(1-alphak12)+mk12*alphak12;
    Ikf=GKf*mkf*(V-Ek); %currents
    Ik74=GK74*mk74*(V-Ek);
    Ikn=GKn*mkn*(V-Ek);
    Ik11=GKv11*mk11*(V-Ek);
    Ik12=GKv12*mk12*(V-Ek);
    Ik18=GKv18*mk18*(V-Ek);
    Ik=Ikf+Ik74+Ikn+Ik11+Ik12+Ik18; %total K+ current
    dV=-(Ileak+Imet+Ik)/Cm; % Update the IHC potential
    V=V+dV*dt;
end
% here run the model with the input stimulus
mtIn=mtIn(100e-3*fs+1:end);
for i=1:length(mtIn)
    mt=alphaMet*mt+(1-alphaMet)*mtIn(i);
    Imet=(Gmet*mt)*(V-EP);    
    Ileak=Gleak*(V);
    % "blocked" channels are not voltage dependent, 
    % their activation is that at the resting potential
    if(~any(strcmp('Kf',block_list))) 
    mkf=1/(1+exp(-(V-Xkf)/SKf))*(1-alphakf)+mkf*alphakf;
    end
    if(~any(strcmp('K74',block_list)))
    mk74=1/(1+exp(-(V-Xk74)/SK74))*(1-alphakn)+mk74*alphakn;
    end
    if(~any(strcmp('Kn',block_list)))
    mkn=1/(1+exp(-(V-Xkn)/SKn))*(1-alphakn)+mkn*alphakn;
    end
    if(~any(strcmp('K11',block_list)))
    mk11=1/(1+exp(-(V-Xk11)/SK11))*(1-alphak11)+mk11*alphak11;
    end
    if(~any(strcmp('K18',block_list)))
    mk18=1/(1+exp(-(V-Xk18)/SK18))*(1-alphak18)+mk18*alphak18;
    end
    if(~any(strcmp('K12',block_list)))
    mk12=1/(1+exp(-(V-Xk12)/SK12))*(1-alphak12)+mk12*alphak12;
    end
    Ikf=GKf*mkf*(V-Ek);
    Ik74=GK74*mk74*(V-Ek);
    Ikn=GKn*mkn*(V-Ek);
    Ik11=GKv11*mk11*(V-Ek);
    Ik12=GKv12*mk12*(V-Ek);
    Ik18=GKv18*mk18*(V-Ek);
    Ik=Ikf+Ik74+Ikn+Ik11+Ik12+Ik18;
    dV=-(Ileak+Imet+Ik)/Cm;
    V=V+dV*dt;
    
    K74(i)=Ik74; % Save the output variables
    Kn(i)=Ikn;
    K11(i)=Ik11;
    K18(i)=Ik18;
    K12(i)=Ik12;
    Kf(i)=Ikf;
    MET(i)=Imet;
    Vm(i)=V; 
end


