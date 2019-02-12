# Immunocommensal_TiM
This repository contains the MATLAB scripts used to generate the figures in the paper "Not by (Good) Microbes Alone: Towards Immunocommensal Therapies" by Chung Yin Leung and Joshua S. Weitz (Trends in Microbiology, in press, available online https://doi.org/10.1016/j.tim.2018.12.006).

The scripts are divided into folders corresponding to the different subfigures of Fig. 3.

Instructions: 

Fig3A_time_series: 
Run "Run_commensal_time_series.m" to generate the 3 time series panels in Fig. 3A.

Fig3B1_regimes_immune: 
Each folder in this directory corresponds to one panel of Fig. 3B1. Run "Run_immune_regimes.m" to generate the figures. For completeness, heat maps of the steady-state densities of pathogen and commensal will also be plotted (Fig3B1_p*_pathogen and Fig3B1_p*_commensal).

Fig3B2_regimes_commensal: 
Each folder in this directory corresponds to one panel of Fig. 3B2. Run "Run_commensal_regimes.m" to generate the figures. For completeness, heat maps of the steady-state densities of pathogen and commensal will also be plotted (Fig3B2_p*_pathogen and Fig3B2_p*_commensal).

Caption of Fig. 3: 
Population dynamics and regimes of steady states from the model at different levels of host immunity and commensal protection. (A) Commensal competition and host immune response can synergistically eliminate the pathogen even when neither of them can do so alone. The figures show time series of population densities of pathogen $B_P$, commensal $B_C$ and host immune effector $I$. The panels correspond to cases with the pathogen interacting with commensal bacteria only, host immunity only, and a combination of commensal and host immunity. The bacterial competition parameters are given by $\lambda_{PC}=0.75$ and $\lambda_{CP}=1.25$. (B1-B2) The combination of commensal competition and host immunity lowers the commensal inhibitory strength and immune killing rate required for pathogen elimination. (B1) Different regimes of infection outcomes as functions of the competition parameters $\lambda_{CP}$ and $\lambda_{PC}$ at different levels of immune responses: no immunity, low immune killing ($\epsilon K_I=0.82$ h$^{-1}$) and high immune killing ($\epsilon K_I=1.97$ h$^{-1}$). (B2) Different regimes of infection outcomes as functions of $\lambda_{CP}$ and maximum immune killing rate $\epsilon K_I$ at different levels of commensal inhibition: no commensal, low inhibition ($\lambda_{PC}=0.75$) and high inhibition ($\lambda_{PC}=1.25$). The black dashed line and dotted line mark the thresholds of the different parameter regimes. The parameters for all simulations are given by $r_P=r_C=0.75$ h$^{-1}$, $K_P=K_C=10^{10}$ cell/g, $\epsilon =8.2\times 10^{-8}$ g/(h cell), $K_D=4.1\times 10^7$ cell/g, $\alpha =0.97$ h$^{-1}$, and $K_N=10^7$ cell/g. The initial conditions are $B_{P0}=3\times 10^7$ (g$^{-1}$), $B_{C0}=10^9$ (g$^{-1}$), and $I_0=2.7\times 10^6$ (g$^{-1}$).
