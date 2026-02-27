![R](https://img.shields.io/badge/R-%3E%3D%204.2-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
[![B3 Project](https://img.shields.io/badge/B3-Biodiversity%20Building%20Blocks%20for%20Policy-blue)](https://b-cubed.eu/)



## 📦 Required Packages

```r
library(imageRy) # from GitHub or CRAN
library(terra) # from CRAN
library(colorblindcheck) # from CRAN
library(colorblindr) # from GitHub: clauswilke/colorblindr
library(patchwork) # from CRAN
library(cblindplot) # from GitHub: ducciorocchini/cblindplot
library(ggplot2) # from CRAN
```
---

## ⏫ Package Installation

You can install the stable version of the package from **CRAN** or the development version from **GitHub**.

### Install from CRAN

```r
install.packages("packageName")
library(packageName)
```

---

### Install the development version from GitHub

If you don’t have **devtools** installed:

```r
install.packages("devtools")
```

Then install the package from GitHub:

```r
devtools::install_github("username/repository")
library(packageName)
```

---

### Alternative (using remotes)

```r
install.packages("remotes")
remotes::install_github("username/repository")
library(packageName)
```

---

# 🌍 NDVI Computation from Sentinel Imagery

```r
setwd("~/Desktop/")

im.list()

sent <- im.import("sentinel.dolomites")
ndvi <- im.ndvi(sent, 4, 3)
```

---

# 🎨 Comparing Color Palettes

## Grayscale vs Diverging vs Vegetation Palette

```r
clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)
clbr <- colorRampPalette(c("blue","white","red"))(100)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)

par(mfrow=c(1,3))
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

dev.off()
```

---

## ⚠️ Problematic Colorblind Palettes

```r
clblind <- colorRampPalette(c("red","green","blue"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("red","blue","green"))(100)
plot(ndvi, col=clblind)

clblind <- colorRampPalette(c("blue","green","yellow","red"))(100)
plot(ndvi, col=clblind)
```

Red–green combinations may cause interpretation problems for users with color vision deficiencies.

---

# 👁️ Color Vision Simulation

```r
par(mfrow=c(1,2))

palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", 
                             "cyan", "blue"))(100)

palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", 
                                  "dark grey", "light grey", "blue"))(100)

plot(ndvi, col=palraw)
plot(ndvi, col=palraw_grey)
```

---

# 🌈 Vinicunca (Rainbow Mountain) Example

```r
vin <- rast("vinicunca.jpg")
vin <- flip(vin)
plot(vin)
```

## Standard vs Protanopia Simulation

```r
par(mfrow=c(1,2))

im.plotRGB(vin, 1, 2, 3, title="Standard")
im.plotRGB(vin, 3, 2, 1, title="Protanopia")
```

---

# 🎨 Evaluating Rainbow Palettes

```r
rainbow_pal <- rainbow(7)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(100)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(500)
palette_check(rainbow_pal, plot=TRUE)
```

Rainbow palettes often introduce perceptual distortions and accessibility issues.

---

# 📊 Colorblind Simulation with ggplot2

## Example Dataset

```r
iris
```

## Density Plot

```r
explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
  geom_density(alpha=0.7)

explot
```

## Simulate Color Vision Deficiencies

```r
cvd_grid(explot)
```

---

# ✅ Accessible Alternative: Okabe–Ito Palette

```r
explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + 
  scale_fill_OkabeIto()

explot2
```

## Compare Results

```r
explot + explot2
```

The **Okabe–Ito palette** is designed to be colorblind-friendly and perceptually balanced.

---

# 🩺 Simulating Different Types of Color Vision Deficiency

```r
rainbow <- rast("rainbow.jpg")
rainbow <- flip(rainbow)
plot(rainbow)

cblind.plot(rainbow, cvd= "protanopia")
cblind.plot(rainbow, cvd= "deuteranopia")
cblind.plot(rainbow, cvd= "tritanopia")
```

Supported simulations:

* **Protanopia** (red deficiency)
* **Deuteranopia** (green deficiency)
* **Tritanopia** (blue deficiency)

---

# 🎯 Key Takeaways

* Avoid red–green contrasts when possible
* Be cautious with rainbow palettes
* Use colorblind simulation tools during development
* Prefer tested palettes such as **Okabe–Ito**
* Always consider accessibility in scientific visualization

---

## 📚 Related Tools

* `colorblindr`
* `colorblindcheck`
* `cblindplot`
* `ggplot2`
* `terra`
* `imageRy`

---

## 👩‍🔬 Purpose

This repository provides a practical workflow for improving accessibility in:

* Remote sensing
* Raster visualization
* Scientific plotting
* Environmental and ecological analysis

---
