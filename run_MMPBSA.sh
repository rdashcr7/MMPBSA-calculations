
hostname
date
module load cuda/10.0
module load python3/anaconda/2023.9
source activate ~/MMPBSA_env/  # enter path to directory containing this script, the ligand_receptor_binding.py file, 

# === Clean workspace ===
rm -f *.prmtop *.inpcrd *.mdcrd *.log *.dat *.out *.pdb *.dcd *.txt *.csv tleap_*.in tleap_*.log *.json

python3 ligand_receptor_binding.py 

# Path to forcefield files, this should be in the directory of pdb2amber
FF_PROTEIN="./pdb2amber/data/protein.ff14SB.xml"
FF_WATER="./pdb2amber/data/wat_opc3.xml"

pdb4amber -i NVT_complex_dry.pdb -o NVT_complex_dry1.pdb --nohyd

cat > tleap_complex.in << EOF
source leaprc.protein.ff14SB
mol = loadpdb NVT_complex_dry1.pdb
saveamberparm mol complex.prmtop complex.inpcrd
quit
EOF

tleap -f tleap_complex.in > tleap_complex.out 2>&1


ante-MMPBSA.py -p complex.prmtop -c complex.inpcrd -r receptor.prmtop -l ligand.prmtop -m ":1-98"  # in m, insert the residue numbers for the receptor as this will help ante-MMPBSA to mask the receptor and ligand separately for the prmtop files of ligand and receptor

cat > input_complex.json <<EOF
{
    "fname_pdb": "NVT_complex.pdb",
    "fname_prmtop": "complex_solvated.prmtop",
    "fname_inpcrd": "complex_solvated.inpcrd",
    "fname_ff": [
        "${FF_PROTEIN}",
        "${FF_WATER}"
    ]
}
EOF
python3 pdb2amber/pdb2amber.py -i input_complex.json

cat > convert_traj.in <<EOF
parm complex_solvated.prmtop
trajin complex_trajectory.dcd
trajout trajectory.mdcrd
EOF

cpptraj -i convert_traj.in > cpptraj.log 2>&1

cat > mmpbsa.in <<EOF
&general
   startframe=1,
   endframe=25000000,
   interval=1000,
   verbose=1,
   keep_files=0,
   strip_mask=":WAT,HOH,Na+,Cl-,Na,Cl",  
   use_sander=0,
/

&pb
   istrng=0.100,          
   exdi=80.0,             
   indi=1.0,              
   inp=2,                
   radiopt=1,             
   cavity_surften=0.0378,
   cavity_offset=-0.5692,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/
EOF


MMPBSA.py -O \
  -i mmpbsa.in \
  -o binding_energy.dat \
  -sp complex_solvated.prmtop \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory.mdcrd

