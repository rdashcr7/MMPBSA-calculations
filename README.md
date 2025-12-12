📘 MMPBSA-Calculations
🧬 Overview

This repository provides an automated workflow for estimating binding free energies (ΔG) between a ligand and a receptor using molecular dynamics with OpenMM and MMPBSA.py from AmberTools. It integrates simulation, topology generation, trajectory processing, and binding energy calculation in a SLURM-friendly pipeline.

In addition to scripts for production workflows, the repository includes an interactive Jupyter notebook for visualization and exploratory analysis.

🗂️ Repository Contents
File / Script	Purpose
run_MMPBSA.sh	Main SLURM script to run MD simulations and MMPBSA workflow
ligand_receptor_binding.py	Python script for setting up and running solvated MD trajectories
fix_traj.py	Generates dry topology files (*.prmtop) from MD outputs
Animation.ipynb	Jupyter notebook for trajectory visualization and binding analysis
README.md	This documentation

✨ Note: The Jupyter notebook is part of the analysis layer and is useful for interactive inspection of results (animations). 
GitHub

🚀 Features & Workflow

This pipeline supports the following stages:

1. Molecular Dynamics Simulation

Runs energy-minimization and dynamics using OpenMM

Produces:

complex_trajectory.dcd — full NPT trajectory

Stripped PDB files (no solvent/ions)

Dry stripped trajectory (trajectory_dry.dcd) 
GitHub

2. Topology Generation

Uses ParmEd and ante-MMPBSA.py

Generates:

complex.prmtop

receptor.prmtop

ligand.prmtop
(for the dry systems) 
GitHub

3. Trajectory Conversion

Converts DCD to Amber-compatible NetCDF .nc format using mdconvert 
GitHub

4. MMPBSA.py Free Energy Calculation

Runs Poisson–Boltzmann (PB) energy estimation

Optional Generalized Born (GB) support available by editing the input file mmpbsa.in 
GitHub

📊 Jupyter Notebook — Animation.ipynb

The included notebook provides additional capabilities:

Interactive trajectory animation

Plotting and comparison of structural metrics

Visual inspection of simulations prior to energy analysis

You can run this notebook locally with:

jupyter notebook Animation.ipynb


Since notebooks are especially helpful for interpretation and debugging, this file sits outside the SLURM workflow but complements it by enabling interactivity. 
GitHub

🖥️ Prerequisites

Ensure the following are available:

Hardware

HPC cluster with GPU access

Software

AmberTools (with MMPBSA.py, cpptraj, ante-MMPBSA.py)

Python with:

openmm

parmed

mdanalysis

numpy, scipy

openmmtools

(Optional) notebook dependencies for Jupyter

⚙️ How to Run
1) Configure Paths

Update run_MMPBSA.sh:

Python environment

Force field locations

2) Submit SLURM Job
sbatch run_MMPBSA.sh

📦 Output Summary
Binding Energy Results

binding_energy.dat and such files for each block of the analysis
(e.g., every 10 ns)

Structural Metrics

ligand_analysis*.csv, receptor_analysis*.csv, complex_analysis*.csv

RMSD

Radius of gyration

Distance plots

Amber Inputs

.prmtop, .inpcrd, .nc files

Trajectories

Full and stripped trajectories (.dcd, .nc)

Dry PDBs of ligand, receptor, and complex

📌 Notes

TIP3P water used by default

Only PB solvation configured, GB is easily added

Notebook assistance for post-analysis

📬 Contact

For questions or suggestions, please open an issue or reach out:

🧑‍💻 rdash@email.sc.edu

🧪 JABBARI@cec.sc.edu
