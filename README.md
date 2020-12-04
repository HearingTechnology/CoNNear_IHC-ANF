## CoNNear<sub>IHC-ANF</sub>: A convolutional neural-network model of the human inner-hair-cell and auditory-nerve-fiber complex

**The supporting paper is titled "A neural-network framework for modelling auditory sensory cells and synapses" and can be found at [https://doi.org/10.1101/2020.11.25.388546](https://doi.org/10.1101/2020.11.25.388546).**

> This work was funded with support from the EU Horizon 2020 programme under grant agreement No 678120 (RobSpear).


This repository contains a full notebook `connear_notebook.ipynb` for running and testing CoNNear<sub>IHC-ANF</sub>, a CNN model of the inner-hair-cell (IHC) and auditory-nerve (ANF) complex. The outputs of the CoNNear IHC-ANF model are compared against the reference model ([Verhulst et al. 2018, v1.1](https://github.com/HearingTechnology/Verhulstetal2018Model/tree/v1.1-master)). The inputs to the IHC-ANF models are provided by the transmission line (TL) cochlear model included in the reference model. The figures reported in the paper can be reproduced with this notebook, using the cochlea and IHC reference model simulations.

A faster version of the notebook `connear_notebook_light.ipynb` is also provided that uses a CNN model of the whole auditory periphery. The cochlear outputs are simulated using the CoNNear cochlea module and given as inputs to the successive stages of CoNNear and Verhulst et al. models, thus reducing significantly the computational time required. 

Both notebooks consist of different blocks corresponding to the different validation metrics of the paper. Each block can be adapted by the reader to run variations on the simulations that were described in the paper, or to simulate the responses to different stimuli.

Besides the notebooks (both in `.html` and `.ipynb` format) the repository contains the trained CoNNear models (in the connear folder), the reference model's folder (Verhulstetal2018), an `extra_functions.py` python file, this `README.md` document, a license file and a TIMIT speech sentence (`sx228.wav`). 

The CNN approximations of the Dierich et al. IHC model and the Zilany et al. ANF models are also included under the folders Dierich2020 and Zilany2014, respectively. The CNN models can easily be executed standalone, in the same fashion as our CoNNear models. An example notebook `generalisability_notebook.ipynb` is provided that reproduces the IHC-ANF evaluation results for the two CNN models and compares them to the responses of the reference Verhulst et al. IHC-ANF model.

The reference Dierich2020 and Zilany2014 models are designed to be executed in Matlab, thus a jupyter notebook that can directly compare the results of the reference and the corresponding CNN models requires setting-up a Matlab backend for python (or a python implementation of the reference models). A jupyter notebook `generalisability_notebook-full.ipynb` is provided here that can run the two Matlab models, but requires a Matlab installation and the installation of the Matlab engine API for Python. Instructions on how to setup and run this notebook are provided at the end of this file.

## How to test the CoNNear model

1. To run the full notebook for the first time, you'll have to compile the cochlea_utils.c file that is used for solving the TL model of the cochlea. This requires some C++ compiler which should be installed beforehand (more information can be found [here](https://github.com/HearingTechnology/Verhulstetal2018Model#verhulstetal2018model)). 

* For mac/linux:
 Open a terminal, go to the Verhulstetal2018 folder and type:
 
     `gcc -shared -fpic -O3 -ffast-math -o tridiag.so cochlea_utils.c`

* For windows:
 The native GCC compiler from the MinGW project needs to be installed on a Windows machine. After the installation open a terminal, go to the Verhulstetal2018 folder and type:

     `gcc -shared -fpic -O3 -ffast-math -o tridiag.dll cochlea_utils.c`
     
> If running on google colab: add the following as a code block and run it to compile cochlea_utils.c in the runtime machine.

>	!gcc -shared -fpic -O3 -ffast-math -o tridiag.so cochlea_utils.c

To avoid solving the computationally-expensive TL model, the lighter version of the notebook can be executed instead, which uses the CoNNear cochlear model. Due to the neural-network nature of the CoNNear<sub>cochlea</sub>, the results of the light version are slightly different than the ones of the full notebook (and the ones reported in our paper) where our reference TL model is used.

2. To run our notebooks, Numpy, Scipy, Keras and Tensorflow are necessary. We used a conda environment (Anaconda v2020.02) that included the following versions: 
	+ Python 3.6.1
	+ Numpy v1.19.2
	+ Scipy v1.5.4
	+ Keras v2.3.1
	+ Tensorflow v1.15.0

3. Run the code blocks from the "Import required python packages and functions" section of the notebook. All other code blocks are independent and can be run in any order. 

4. Run the desired code blocks and/or adapt the various parameters to look at the performance for similar tasks. Each of the code blocks holds comments to clarify the steps or to define the choice of a parameter value. 
    
## CoNNear IHC-ANF model specifications

The CoNNear<sub>IHC-ANF</sub> model is comprised by four distinct AECNN models, one for the IHC stage and three for the three different ANF types. All models were trained on training sets comprised by 2310 speech sentences of the TIMIT speech dataset. Using the speech dataset as input to the reference model, the outputs of each stage were simulated and were used to train each model.

#### IHC stage

The CoNNear<sub>IHC</sub> model consists of 6 layers, each with 128 filters of 16 filter length, with each layer in the encoder followed by a tanh non-linearity and in the decoder by a sigmoid non-linearity.
It predicts the IHC receptor potential along the frequency channels given as input (by default 201 cochlear channels, resembling a frequency range from 122Hz to 12kHz based on the Greenwood map). 

256 context samples are added at both sides to account for possible loss of information due to the slicing of full speech fragments. 

The CoNNear model can take a stimulus with a variable sample lengths as an input, however, due to the convolutional character of CoNNear, this sample length has to be a multiple of 8 (2<sup>N<sub>enc</sub></sup>, where N<sub>enc</sub> = 3 is the number of layers in the encoder).

#### ANF stage

The ANF stage consists of three models, CoNNear<sub>ANfH</sub>, CoNNear<sub>ANfM</sub> and CoNNear<sub>ANfL</sub>, corresponding to high-spontaneous-rate (HSR), medium-spontaneous-rate (MSR) and low-spontaneous-rate (LSR) fibers, respectively. Each model consists of 28 layers, with 64 filters of 8 filter length each. A PReLU non-linearity is used after each layer of the CoNNear<sub>ANfH</sub> and CoNNear<sub>ANfM</sub>, while a combination of tanh and sigmoid non-linearities is used for the CoNNear<sub>ANfL</sub> model. All three models predict the firing rate of the respective ANF along the frequency channels given as input (by default 201 channels). 

7936 context samples are added on the left side and 256 context samples are added on the right side of the input to the models (see the paper for more details). The ANF models can still take inputs of variable length, however, due to the increased number of layers, this sample length has to be a multiple of 16384 (2<sup>N<sub>enc</sub></sup>, where N<sub>enc</sub> = 14 is the number of layers in the encoder).

## System test

The notebooks were tested on a Windows laptop with an Intel Core i5-8300H CPU @ 2.30 GHz and 8 GB of RAM.

The installation time for the Anaconda environment and dependencies is approximately 20 min. On our system, the run-time of the full notebook was 5 mins for all the blocks of the IHC stage and 20 mins for the ANF stage. The light version of the notebook was executed in ~5 mins in total.

## How to setup the *generalisability_notebook-full* jupyter notebook

To run the notebook, a version of Matlab needs to be installed. Depending on your Matlab version a different python version might be required, we opted for version 3.6.1 for Matlab 2018a, but if you have a different one you might need to change the python version in the first command. The first step is to create a fresh conda environment and install all the required modules:

     conda create --name evaluation_env python==3.6.1 -c conda-forge
     conda activate evaluation_env
     conda install numpy scipy tensorflow==1.15 keras==2.3.1
     conda install ipykernel
     python -m ipykernel install --user --name evaluation_env
     python -m pip install matlab_kernel

After everything is installed, navigate to your MATLAB directory and install the Matlab-python engine (changing \<MATLAB directory> with the directory of your Matlab installation):

     cd “<MATLAB directory>/extern/engines/python”
     python setup.py install
     
If the setup was successful then the Matlab models can be executed within our jupyter notebook. Before running the notebook, make sure that you select the newly-created kernel in jupyter (Kernel > Change Kernel > evaluation_env).

----
For questions, please reach out to one of the corresponding authors

* Fotios Drakopoulos: fotios.drakopoulos@ugent.be
* Deepak Baby: deepakbabycet@gmail.com
* Sarah Verhulst: s.verhulst@ugent.be

