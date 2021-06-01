This folder contains the source data that were used in the graphs of the paper, with each subfolder corresponding to each respective figure. A summary of the data files included in each subfolder can be found below:

Main figures
============

**Figure 2:**
Contains the .csv files with the average IHC receptor potential outputs of the three IHC models (reference IHC, CoNNear IHC tanh and CoNNear IHC tanh/sigmoid) for three different stimulus frequencies (0.5, 1 and 2 kHz). In each file, the first column represents the stimulus frequency (in kHz) and the next columns the simulated receptor potentials across each respective frequency, for stimulus levels from 0 to 100 dB SPL.

**Figure 3:**
a. Contains the .txt files with the simulated AC/DC ratios of the three IHC models (reference IHC, CoNNear IHC tanh and CoNNear IHC tanh/sigmoid), as well as the measured AC/DC ratios of two guinea-pig IHC recordings extracted from Palmer and Russel (1986). In each file, the first column corresponds to the stimulus frequency (in kHz) and the second to the simulated AC/DC ratio at the respective frequency.
b. Contains the .txt files with the RMS of the simulated half-wave-rectified IHC receptor potential in response to a 4-kHz pure tone. In each file, the first column is the stimulus level (0 to 100 dB SPL) and the second one the computed RMS of the IHC receptor potential output for each level.

**Figure 4:**
a. Contains a .txt file with the simulated adaptation time course of the three different AN fiber types, in response to a 1-kHz 70-dB-SPL pure tone. The first column is the time axis and the second, third and fourth are the simulated firing rates of the HSR, MSR and LSR ANFs, respectively.
b. Contains a .txt file with the simulated onset-peak amplitude of the three different AN fiber types for a pair of 2-kHz pure tones with interstimulus intervals from 0.1 to 1.9 s. The first column is the interstimulus interval between the two pure tones and the second, third and fourth columns are the normalized maxima of the HSR, MSR and LSR ANF responses, respectively.
c. Contains the .csv files with the simulated firing rates of three different ANF LSR models to a 70-dB-SPL pure tone, i.e., the reference ANF LSR model, a trained CoNNear ANF model with 16 layers and the final CoNNear ANF model with 28 layers. In all files, the first column is the time dimension and the second one the simulated ANF LSR firing rate.

**Figure 5:**
Contains four subfolders, each one containing the .csv files with the simulated firing rates of the three different AN fiber types, corresponding to the responses to four 70-dB-SPL tonal stimuli (1 & 4 kHz pure tone, 1 & 4 kHz SAM tone). For each stimulus, the simulated firing rates of the three ANFs are provided for the reference ANF model and the trained CoNNear models with the different activation-function combinations (PReLU, tanh/PReLU and tanh/sigmoid). In each file, the first dimension corresponds to the time vector and the second one to the simulated ANF firing rate across time.

**Figure 6:**
a. Contains the .txt files with the simulated rate-level curves of the three ANF types (HSR, MSR and LSR), for the reference ANF model and the trained CoNNear models with the different activation-function combinations (PReLU, tanh/PReLU and tanh/sigmoid). Measured data from guinea-pig and mouse AN recordings are also included, extracted from Fig. 1 of Winter and Palmer (1991) and Fig. 6 of Taberner and Liberman (2005), respectively. In each file, the first column contains the stimulus levels, the second the simulated average firing rates to a 1-kHz stimulus (for each respective level) and the third one the firing rates to a 4-kHz stimulus.
b. Contains the .txt files with the simulated synchrony-level curves of the three ANF types (HSR, MSR and LSR), for the reference ANF model and the trained CoNNear models with the different activation-function combinations (PReLU, tanh/PReLU and tanh/sigmoid). Measured data from cat AN recordings are also included, extracted from Figs. 5 and 8 of Joris and Yin (1992). In each file, the first column contains the stimulus levels, the second one the simulated vector strength to a 1-kHz stimulus (for each stimulus level) and the third one the vector strength to a 4-kHz stimulus.

**Figure 7:**
a. Contains the .txt files with the simulated AC/DC ratios of the two analytical IHC models (Zilany2014 and Dierich2020) and the two CNN models (CoNNearIHC and Dierich2020-CNN), as well as the measured AC/DC ratios of the two guinea-pig recordings from Palmer and Russel (1986). In each file, the first column corresponds to the stimulus frequency (in kHz) and the second to the simulated AC/DC ratio at the respective frequency.
b. Contains the .csv files with the simulated IHC receptor potential output of the reference Dierich2020 IHC model and the respective CNN approximation in response to a 70-dB-SPL 1-kHz pure tone, as well as the envelope estimation of the simulated IHC receptor potential output of the reference Dierich2020 IHC model. In each file, the first column corresponds to the time vector and the second one to the simulated response over time.
c. Contains the .txt files with the simulated rate-level curves of the three ANF types (HSR, MSR and LSR), for the two analytical ANF models (Zilany2014 and Bruce2018) and the two CNN models (CoNNearANF and Zilany2014-CNN). Measured data from guinea-pig and mouse recordings are also included from Fig. 1 of Winter and Palmer (1991) and Fig. 6 of Taberner and Liberman (2005), respectively. In each file, the first column contains the stimulus levels, the second one the simulated average firing rates to a 1-kHz stimulus (for each respective level) and the third one the firing rates to a 4-kHz stimulus.
d. Contains the .txt files with the simulated synchrony-level curves of the three ANF types (HSR, MSR and LSR), for the two analytical ANF models (Zilany2014 and Bruce2018) and the two CNN models (CoNNearANF and Zilany2014-CNN). Measured data from cat recordings are also included from Figs. 5 and 8 of Joris and Yin (1992). In each file, the first column contains the stimulus levels, the second one the simulated vector strength to a 1-kHz stimulus (for each stimulus level) and the third one the vector strength to a 4-kHz stimulus.
e. Contains the .csv files with the simulated firing rates of the three different AN fiber types for the reference Zilany2014 ANF model and the respective CNN approximation, in response to a 70-dB-SPL 1-kHz pure tone and a 70-dB-SPL 1-kHz SAM tone. In each file, the first column corresponds to the time vector and the second to the simulated response over time.

**Figure 8:**
Contains the .csv files with the two SAM 4-kHz tonal stimuli (unprocessed and DNN processed), the response of the 10-HSR-ANF model to the unprocessed stimulus, as well as the responses of the 8-HSR-ANF model to both the unprocessed and the processed stimuli.

Supplementary Figures
=====================

**Supplementary Figure 1:**
Contains the .txt files with the root-mean-squared errors (RMSEs) between the simulated average IHC receptor potential outputs of the reference IHC model and the trained CoNNear models with the different activation-function combinations (CoNNear IHC tanh and CoNNear IHC tanh/sigmoid). In each file, the first column corresponds to the stimulus level (0 to 90 dB SPL) and the remaining columns to the RMSEs (at each stimulus level) for pure-tone stimuli of 0.25, 0.5, 1, 2, 4 and 8 kHz, respectively.

**Supplementary Figure 3:**
Contains the .txt files with the computed RMSEs between the simulated ANF firing rates of the reference ANF model and the trained CoNNear ANF models with the different activation-function combinations (PReLU, tanh/PReLU and tanh/sigmoid). As indicated by the header of each file, the first column corresponds to the stimulus level (0 to 90 dB SPL) and the remaining columns to the RMSEs (at each stimulus level) for four tonal stimuli (1 & 4 kHz pure tone, 1 & 4 kHz SAM tone) and successively for each fiber type (HSR, MSR and LSR).

**Supplementary Figure 5:**
Contains a .txt file with the computed RMSEs between simulated average IHC receptor potential outputs of the Dierich et al. IHC model and the respective CNN approximation (a), as well as a .txt file with the computed RMSEs between simulated ANF firing rates of the Zilany et al. ANF model and the respective CNN approximation (b). As indicated by the header of each file, the first column corresponds to the stimulus level (0 to 90 dB SPL) and the remaining columns to the RMSEs (at each stimulus level) for each tonal stimulus.

**Supplementary Figure 6:**
Contains the .csv files with generated step current stimuli from 0 to 100 μA/cm^2 and the responses of the reference HH model and the respective CNN approximation to these stimuli. In each file, the first column corresponds to the time axis and the remaining columns to the stimulus or responses of each level across time.

