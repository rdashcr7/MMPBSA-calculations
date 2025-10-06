
hostname
date
module load cuda/10.0
module load python3/anaconda/2023.9
source activate ~/MMPBSA_env/  # enter path to directory containing this script, the ligand_receptor_binding.py file, 

# === Clean workspace ===
rm -f *.prmtop *.inpcrd *.mdcrd *.log *.dat *.out *.pdb *.dcd *.txt *.csv tleap_*.in tleap_*.log *.json
rm reference.frc
rm -f _MMPBSA_*
rm -f mmpbsa.in
rm -f mmpbsa1.in
rm -f mmpbsa2.in
rm -f mmpbsa3.in
rm -f mmpbsa4.in
rm -f mmpbsa5.in

python3 ligand_receptor_binding.py 

python3 fix_traj.py

ante-MMPBSA.py -p complex.prmtop -c complex.inpcrd -r receptor.prmtop -l ligand.prmtop -m ":1-98"

mdconvert -o trajectory_cleaned.nc -t complex.prmtop trajectory_dry.dcd

cat > mmpbsa.in <<EOF
&general
   startframe=1,
   endframe=25001,
   interval=250,
   keep_files=0,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=0.92,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa.in \
  -o binding_energy.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc

# first 5000 frames
cat > mmpbsa1.in <<EOF
&general
   startframe=1,
   endframe=5001,
   interval=50,
   keep_files=0,
   entropy=1,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=-1.008,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa1.in \
  -o binding_energy1.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc

# 5000-10000 frames
cat > mmpbsa2.in <<EOF
&general
   startframe=5001,
   endframe=10001,
   interval=50,
   keep_files=0,
   entropy=1,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=-1.008,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa2.in \
  -o binding_energy2.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc

# 10000 - 15000 frames
cat > mmpbsa3.in <<EOF
&general
   startframe=10001,
   endframe=15001,
   interval=50,
   keep_files=0,
   entropy=1,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=-1.008,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa3.in \
  -o binding_energy3.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc

# 15000 - 20000 frames
cat > mmpbsa4.in <<EOF
&general
   startframe=15001,
   endframe=20001,
   interval=50,
   keep_files=0,
   entropy=1,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=-1.008,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa4.in \
  -o binding_energy4.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc


# 20000 - 25000 frames
cat > mmpbsa5.in <<EOF
&general
   startframe=20001,
   endframe=25001,
   interval=50,
   keep_files=0,
   entropy=1,
/

&pb
   istrng=0.150,
   exdi=80.0,
   indi=4.0,
   inp=2,
   radiopt=0,
   cavity_surften=0.00542,
   cavity_offset=-1.008,
   scale=2.0,
   prbrad=1.4,
   fillratio=4.0,
   linit=1000,
/

&gb
   igb=5,
   saltcon=0.150,
/
EOF

MMPBSA.py -O \
  -i mmpbsa5.in \
  -o binding_energy5.dat \
  -cp complex.prmtop \
  -rp receptor.prmtop \
  -lp ligand.prmtop \
  -y trajectory_cleaned.nc
