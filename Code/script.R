# Code for simulating and solving colorblindness issues

library(imageRy)        # Functions for image import, NDVI calculation, and raster visualization
library(terra)          # Handling raster data (reading, manipulating, plotting spatial rasters)
library(colorblindcheck) # Tools to evaluate color palettes for color vision deficiencies
library(colorblindr)    # Simulate how ggplot visuals appear under different colorblind conditions
library(patchwork)      # Combine multiple ggplot objects into a single layout
library(cblindplot)     # Simulate colorblind perception on raster/images

# List available images 
im.list()

# Import Sentinel satellite image (Dolomites area)
sent <- im.import("sentinel.dolomites")

# Compute NDVI (Normalized Difference Vegetation Index)
# Using band 4 (NIR) and band 3 (Red)
ndvi <- im.ndvi(sent, 4, 3)

# Define different color palettes for NDVI visualization
clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)  # grayscale
clbr <- colorRampPalette(c("blue","white","red"))(100)              # diverging (cool-warm)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)          # vegetation-like

# Plot NDVI with different palettes for comparison
par(mfrow=c(1,3))
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

# Close plotting device
dev.off()

# Test color palettes that may be problematic for colorblind users
clblind <- colorRampPalette(c("red","green","blue"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("red","blue","green"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("blue","green","yellow","red"))(100)
plot(ndvi, col=clblind)

############### Color vision simulation ################

# Compare raw palette vs a more colorblind-safe palette
par(mfrow=c(1,2))

# Original palette (potentially problematic)
palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", "cyan",
                             "blue"))(100)

# Modified palette with more distinguishable tones for colorblind users
palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", "dark grey",
                                  "light grey", "blue"))(100)

# Plot NDVI with both palettes
plot(ndvi, col=palraw)
plot(ndvi, col=palraw_grey)

# Reset plotting device
dev.off()

################ Vinicunca example ################

# Set working directory where the image is stored
setwd("~/Downloads/")

# Load RGB image (Vinicunca mountain)
vin <- rast("vinicunca.jpg")

# Flip image vertically (if needed for correct orientation)
vin <- flip(vin)

# Plot original image
plot(vin)

# Compare normal RGB vs simulated protanopia (red-blindness)
par(mfrow=c(1,2))
im.plotRGB(vin, 1, 2, 3, title="Standard")
im.plotRGB(vin, 3, 2, 1, title="Protanopia")

################ Palette testing ################

# Generate rainbow palette and test colorblind accessibility
rainbow_pal <- rainbow(7)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(100)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(500)
palette_check(rainbow_pal, plot=TRUE)

################ ggplot + colorblind simulation ################

# Load example dataset
iris

# Create density plot with default colors
explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
  geom_density(alpha=0.7)

# Show plot
explot

# Simulate how the plot appears under different color vision deficiencies
cvd_grid(explot)

# Create improved version using Okabe-Ito palette (colorblind-friendly)
explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + 
  scale_fill_OkabeIto()

# Show improved plot
explot2

# Compare original vs improved
explot + explot2

################ Raster colorblind simulation ################

# Load NDVI image with rainbow palette
rainbow <- im.import("NDVI_rainbow.png")

# Correct orientation
rainbow <- flip(rainbow)

# Plot original image
plot(rainbow)

# Simulate different types of color vision deficiency
cblind.plot(rainbow, cvd= "protanopia")     # red deficiency
cblind.plot(rainbow, cvd= "deuteranopia")   # green deficiency
cblind.plot(rainbow, cvd= "tritanopia")     # blue deficiency
