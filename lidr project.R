# lidR learning project: canopy height model and structure metrics
# Data: sample file MixedConifer.laz that ships with the lidR package
# Author: Sadia Jamin Haque Suchi

library(lidR)
library(terra)

# 1. Read the point cloud
file <- system.file("extdata", "MixedConifer.laz", package = "lidR")
las  <- readLAS(file)
las                          # point count, extent, density, CRS
summary(las$Z)
table(las$Classification)    # class 2 = ground

# 2. Normalise heights (height above ground)
nlas <- normalize_height(las, tin())

# 3. Canopy height model (1 m cells)
chm <- rasterize_canopy(nlas, res = 1, algorithm = p2r())
png("chm.png", width = 800, height = 800); plot(chm, main = "Canopy height model (m)"); dev.off()

# 4. Structure metrics per 20 m cell
metrics <- pixel_metrics(
  nlas,
  ~list(zmean = mean(Z), zsd = sd(Z), zmax = max(Z), cover = mean(Z > 2)),
  res = 20
)
png("metrics.png", width = 1000, height = 800); plot(metrics); dev.off()

# 5. Individual tree tops
ttops <- locate_trees(chm, lmf(ws = 5))
png("treetops.png", width = 800, height = 800)
plot(chm, main = "Detected tree tops")
plot(sf::st_geometry(ttops), add = TRUE, pch = 3)
dev.off()