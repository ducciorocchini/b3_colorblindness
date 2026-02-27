# Code for simulating and solving colorblindness issues

library(imageRy)
library(terra)
library(colorblindcheck)
library(colorblindr)
library(patchwork)
library(cblindplot)

setwd("~/Desktop/")

im.list()

sent <- im.import("sentinel.dolomites")
ndvi <- im.ndvi(sent, 4, 3)

clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)
clbr <- colorRampPalette(c("blue","white","red"))(100)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)

par(mfrow=c(1,3))
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

dev.off()
clblind <- colorRampPalette(c("red","green","blue"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("red","blue","green"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("blue","green","yellow","red"))(100)
plot(ndvi, col=clblind)

############### Color vision simulation

par(mfrow=c(1,2))

palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", "cyan",
                             "blue"))(100)
palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", "dark grey",
                                  "light grey", "blue"))(100)

plot(ndvi, col=palraw)
plot(ndvi, col=palraw_grey)

# Vinicunca

dev.off()

vin <- rast("vinicunca.jpg")
vin <- flip(vin)
plot(vin)

par(mfrow=c(1,2))
im.plotRGB(vin, 1, 2, 3, title="Standard")
im.plotRGB(vin, 3, 2, 1, title="Protanopia")

# Reproducing color ramp palette and colorblind vision
# library(colorblindcheck)

rainbow_pal <- rainbow(7)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(100)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(500)
palette_check(rainbow_pal, plot=TRUE)

# colorblindr
iris

explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
geom_density(alpha=0.7)
explot

cvd_grid(explot)

explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + scale_fill_OkabeIto()
explot2

explot + explot2

# solving the issues related to different diseases
rainbow <- rast("rainbow.jpg")
rainbow <- flip(rainbow)
plot(rainbow)
cblind.plot(rainbow, cvd= "protanopia")
cblind.plot(rainbow, cvd= "deuteranopia")
cblind.plot(rainbow, cvd= "tritanopia")
