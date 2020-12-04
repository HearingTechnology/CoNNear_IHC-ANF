# for running the Transmision line model using python
import numpy as np
import scipy as sp
import scipy.io as sio
from .cochlear_model2018 import *
import os
import warnings
import multiprocessing as mp
import ctypes as c
import time
import sys
from . import inner_hair_cell2018 as ihc
from . import auditory_nerve2018 as anf
from . import ic_cn2018 as nuclei

#this relates to python 3.6 on ubuntu
#there is one future warning related to "scipy.signal.decimate" in this file
#there is one runtime warning related to firwin "scipy.signal.decimate" in ic_cn2017.py (not important)
#so we suppress these warnings here
warnings.filterwarnings("ignore")

def solve_one_cochlea(model): #definition here, to have all the parameter implicit
    ii=model[3]
    coch=model[0]
    opts = model[4]
    
    sheraPo = opts['sheraPo']
    storeflag = opts ['storeflag']
    probe_points = opts ['probe_points']
    Fs = opts ['Fs']
    subjectNo = opts ['subjectNo']
    sectionsNo = opts ['sectionsNo']
    output_folder = opts ['output_folder']
    numH = opts ['numH'] 
    numM = opts ['numM'] 
    numL = opts ['numL']
    IrrPct = opts ['IrrPct']
    nl = opts ['nl']
    L = opts ['L']
    
    coch.init_model(model[1],Fs,sectionsNo,probe_points,Zweig_irregularities=model[2],sheraPo=sheraPo,subject=subjectNo,IrrPct=IrrPct,non_linearity_type=nl)
    coch.solve()
    magic_constant=0.118;
    Vm=ihc.inner_hair_cell_potential(coch.Vsolution*magic_constant,Fs)
    dec_factor=5
    Vm_resampled=sp.signal.decimate(Vm,dec_factor,axis=0,n=30,ftype='fir')
    Vm_resampled[0:5,:]=Vm[0,0]; #resting value to eliminate noise from decimate
    Fs_res=Fs/dec_factor
    matcontent = {}
    matcontent [u'fs_bm'] = Fs
    matcontent[u'fs_ihc'] = Fs
    matcontent[u'fs_an'] = Fs_res
    matcontent[u'fs_abr'] = Fs_res
    
    if 'v' in storeflag:
        matcontent[u'v'] = coch.Vsolution
    if 'y' in storeflag:
        matcontent[u'y'] = coch.Ysolution
    if 'i' in storeflag:
        matcontent[u'ihc'] = Vm
    if 'h' in storeflag or 'b' in storeflag:
        anfH=anf.auditory_nerve_fiber(Vm_resampled,Fs_res,2)*Fs_res
    if 'h' in storeflag:
        matcontent[u'anfH'] = anfH
    if 'm' in storeflag or 'b' in storeflag:
        anfM=anf.auditory_nerve_fiber(Vm_resampled,Fs_res,1)*Fs_res
    if 'm' in storeflag:
        matcontent[u'anfM'] = anfM
    if 'l' in storeflag or 'b' in storeflag:
        anfL=anf.auditory_nerve_fiber(Vm_resampled,Fs_res,0)*Fs_res
    if 'l' in storeflag:
        matcontent[u'anfL'] = anfL
    if 'e' in storeflag:
        matcontent[u'e'] = coch.oto_emission
    if 'b' in storeflag or 'w' in storeflag:
        cn,anSummed=nuclei.cochlearNuclei(anfH,anfM,anfL,numH,numM,numL,Fs_res)
        ic=nuclei.inferiorColliculus(cn,Fs_res)
        if 'b' in storeflag:
            matcontent[u'cn'] = cn
            matcontent[u'an_summed'] = anSummed
            matcontent[u'ic'] = ic
        if 'w' in storeflag:
            w1=nuclei.M1*np.sum(anSummed,axis=1);
            w3=nuclei.M3*np.sum(cn,axis=1)
            w5=nuclei.M5*np.sum(ic,axis=1)
            matcontent[u'w1'] = w1
            matcontent[u'w3'] = w3
            matcontent[u'w5'] = w5
    matcontent[u'cf'] = coch.cf
    
    return matcontent
