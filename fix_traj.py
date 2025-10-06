import parmed as pmd
from openmm import app
from openmm.app import ForceField, PDBFile


pdb = PDBFile("NPT_complex_dry.pdb")

forcefield_file = "Forcefield_files/amber14-all.xml"
water_model = "Forcefield_files/amber14/tip3pfb.xml"  
forcefield = ForceField(forcefield_file, water_model)

system = forcefield.createSystem(
    pdb.topology,
    nonbondedMethod=app.NoCutoff,
    constraints=None
)


structure = pmd.openmm.load_topology(
    pdb.topology,
    system,
    xyz=pdb.positions
)

# Save to Amber topology/coordinates
structure.save("complex.prmtop", overwrite=True)
structure.save("complex.inpcrd", overwrite=True)

print("? complex.prmtop and complex.inpcrd generated successfully!")
