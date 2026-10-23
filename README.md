# lidR-canopy-learning-project
A short learning project exploring the lidR package in R, using the sample
point cloud (MixedConifer.laz) included with lidR.

What it does:
- reads a LAS/LAZ point cloud and inspects it
- normalises heights above ground
- builds a canopy height model
- computes structure metrics (mean height, height SD, max height, canopy cover)
- detects individual tree tops

Next step: repeat the workflow with National Land Survey of Finland open
laser scanning data (CC BY 4.0).

Software: R, lidR, terra
