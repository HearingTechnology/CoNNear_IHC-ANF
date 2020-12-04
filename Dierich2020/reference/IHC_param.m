%    Script supplementing:
%    "Dierich et al., Optimized Tuning of Auditory Inner Hair Cells to Encode Complex Sound through 
%    Synergistic Activity of Six Independent K+ Current Entities", Cell Reports (2020) 32, 107869
%    https://doi.org/10.1016/j.celrep.2020.107869
%    For fair use only.

Cm=9.8e-12;

load CurrPar.mat
Gmet=30e-9; %MET channel max conductance
s0=16e-9; % Parameters of Boltzmann nonlinearity describing MET channels, \
s1=s0*3; %for details see Appendix A of Altoe et al. (2018) Hear. Res. 364, 68-80
x0=20e-9;
Gleak=0e-9; % no membrane leakage
tauMet=50e-6; % time constant of activation of MET channels

EP=90e-3; % Endocochlear potential
Ek=-70e-3; % K+ reversal potential 

GKv11=GKv11*Cm/1e-12; %Max. conductance of the various channel, see "IHC_model.m" for details
GKv18=GKv18*Cm/1e-12;
GK74=GK74*Cm/1e-12;
GKn=GKn*Cm/1e-12;
GKf=GKf*Cm/1e-12;
GKv12=GKv12*Cm/1e-12;

tot_K=GKv11+GKv12+GKv18+GK74+GKn+GKf; %total K+ conductance

tauKf=0.3e-3; % time constant of Fast-activating K+ channels, based on Kros and Crawford (1990), J. Physiol. 421, 263-291
Ileak=0.0e-9; % no leakage currents
