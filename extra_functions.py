import numpy as np
import tensorflow as tf
import scipy.signal as sp_sig
import scipy.io.wavfile

from keras.models import model_from_json, Model
from keras.utils import CustomObjectScope
from keras.initializers import glorot_uniform

def load_connear_model(modeldir,json_name="/Gmodel.json",weights_name="/Gmodel.h5",crop=1,name=[]):
    #print ("loading model from " + modeldir )
    json_file = open (modeldir + json_name, "r")
    loaded_model_json = json_file.read()
    json_file.close()

    with CustomObjectScope({'GlorotUniform': glorot_uniform()}):
        model = model_from_json(loaded_model_json, custom_objects={'tf': tf})
    if name:
        model.name = name
    model.load_weights(modeldir + weights_name)
    
    if not crop: # for connecting the different modules
        model=model.layers[1]
        if name:
            model=Model(model.layers[0].input, model.layers[-2].output,name=name)
        else:
            model=Model(model.layers[0].input, model.layers[-2].output) # get uncropped output
    #else:
    #    model=Model(model.layers[0].input, model.layers[-1].output) # get cropped output

    return model
    
def rms (x, axis=0):
    # compute rms of a matrix
    sq = np.mean(np.square(x), axis = axis)
    return np.sqrt(sq)

def wavfile_read(wavfile,fs=[]):
    # if fs is given the signal is resampled to the given sampling frequency
    fs_signal, speech = scipy.io.wavfile.read(wavfile)
    if not fs:
        fs=fs_signal

    if speech.dtype == 'int16':
        nb_bits = 16 # -> 16-bit wav files
    elif speech.dtype == 'int32':
        nb_bits = 32 # -> 32-bit wav files
    max_nb_bit = float(2 ** (nb_bits - 1))
    speech = speech / (max_nb_bit + 1.0) # scale the signal to [-1.0,1.0]

    if fs_signal != fs :
        signalr = sp_sig.resample_poly(speech, fs, fs_signal)
    else:
        signalr = speech

    return signalr, fs