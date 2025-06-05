# MMPBSA-calculations


🧬 ΔG Binding Free Energy Calculation Using OpenMM and MMPBSA.py
This repository provides a SLURM-compatible workflow for calculating the binding free energy (ΔG) between a ligand and a receptor using the MMPBSA.py tool from the AMBER suite. It integrates OpenMM-based molecular dynamics to perform simulations and generates input files automatically for MMPBSA analysis.

📁 Repository Contents

run_mmpbsa.sh – Main SLURM script that performs:

NVT MD simulation using OpenMM (via ligand_receptor_binding.py)

Parameter/topology file generation via pdb2amber and tleap

Trajectory conversion via cpptraj

MMPBSA free energy calculation

ligand_receptor_binding.py – Python script to simulate solvated MD for the ligand–receptor complex and output the trajectory.

pdb2amber/ – Folder containing pdb2amber, a utility to generate AMBER-compatible topology files using OpenMM forcefields.

What This Workflow Does -

a) MD Simulation

Runs a 50 ns NVT simulation for a receptor-ligand complex using OpenMM. The trajectory is written to complex_trajectory.dcd, and final structures are saved as PDB files. These final files are stripped of water and ions. These are dry pdb files.

b) Topology Generation for MMPBSA

Uses pdb2amber and tleap to create:

complex.prmtop, receptor.prmtop, ligand.prmtop (dry systems)

complex_solvated.prmtop (solvated system for trajectory)

Trajectory Conversion

Converts .dcd trajectory to AMBER-readable .mdcrd format using cpptraj.

c) MMPBSA Analysis

Performs Poisson–Boltzmann (PB) binding energy calculations on the solvated trajectory using MMPBSA.py.

🖥️ Prerequisites

HPC cluster with GPU access

AmberTools installed (including MMPBSA.py, cpptraj, ante-MMPBSA.py)

Python environment with:

openmm, mdanalysis, numpy, scipy, parmed, etc.

Clone pdb2amber into your working directory by pasting this in the same directory as the slurm and python scripts:

https://github.com/swillow/pdb2amber.git

⚙️ How to Run

Update the paths in run_mmpbsa.sh if needed (e.g., force field files, conda env path).

Submit the job:

sbatch run_mmpbsa.sh


📦 Output Files


a) binding_energy.dat: Final binding free energy output

b) ligand_analysis.csv, receptor_analysis.csv, complex_analysis.csv: Structural properties from the simulation (Rg, RMSD, distance, etc.)

c) .prmtop, .inpcrd, .mdcrd: AMBER input files

d) complex_trajectory.dcd: Trajectory file from OpenMM

e) pdb files of ligand, receptor and complex stripped of water and ions

📌 Notes

TIP3P water model is used.

Only PB solvation model is configured in mmpbsa.in, but GB can be easily added.

📬 Contact

For questions, feel free to open an issue or contact the author via email: rdash@email.sc.edu.








