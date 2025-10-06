# MMPBSA-calculations


🧬 ΔG Binding Free Energy Calculation Using OpenMM and MMPBSA.py
This repository provides a SLURM-compatible workflow for calculating the binding free energy (ΔG) between a ligand and a receptor using the MMPBSA.py tool from the AMBER suite. It integrates OpenMM-based molecular dynamics to perform simulations and generates input files automatically for MMPBSA analysis.

📁 Repository Contents

run_mmpbsa.sh – Main SLURM script that performs:

NVT MD simulation using OpenMM (via ligand_receptor_binding.py)

NPT MD simulation using openMM (via ligand_receptor_binding.py)

Parameter/topology file generation via ParmEd

Trajectory conversion via mdconvert

MMPBSA free energy calculation

ligand_receptor_binding.py – Python script to simulate solvated MD for the ligand–receptor complex and output the trajectory.

What This Workflow Does -

a) MD Simulation

Runs a 50 ns NVT and a 50 ns NPT simulation for a receptor-ligand complex using OpenMM. The NPT trajectory is written to complex_trajectory.dcd, and final structures are saved as PDB files. These final files are stripped of water and ions. These are dry pdb files. The trajectory files if also stripped off water and ions and saved as trajectory_dry.dcd. 

b) Topology Generation for MMPBSA

Uses ParmEd and ante-MMPBSA.py to create:

complex.prmtop, receptor.prmtop, ligand.prmtop (dry systems)

Trajectory Conversion

Converts .dcd trajectory to AMBER-readable .nc format using mdconvert.

c) MMPBSA Analysis

Performs Poisson–Boltzmann (PB) binding energy calculations on the solvated trajectory using MMPBSA.py.

🖥️ Prerequisites

HPC cluster with GPU access

AmberTools installed (including MMPBSA.py, cpptraj, ante-MMPBSA.py)

Python environment with:

openmm, mdanalysis, numpy, scipy, parmed, openmmtools etc.

⚙️ How to Run

Update the paths in run_mmpbsa.sh if needed (e.g., force field files, conda env path).

Submit the job:

sbatch run_mmpbsa.sh


📦 Output Files


a) binding_energy.dat and similar .dat files for every 10 ns interval: Final binding free energy output

b) ligand_analysis.csv, receptor_analysis.csv, complex_analysis.csv: Structural properties from the NVT simulation (Rg, RMSD, distance, etc.)

c) ligand_analysis_npt.csv, receptor_analysis_npt.csv, complex_analysis_npt.csv: Structural properties from the NPT simulation (Rg, RMSD, distance, etc.)

d) .prmtop, .inpcrd, .nc: AMBER input files

e) complex_trajectory.dcd: Trajectory file from OpenMM

f) pdb files of ligand, receptor and complex stripped of water and ions

📌 Notes

TIP3P water model is used.

Only PB solvation model is configured in mmpbsa.in, but GB can be easily added.

📬 Contact

For questions, feel free to open an issue or contact the authors via email: rdash@email.sc.edu, JABBARI@cec.sc.edu.








