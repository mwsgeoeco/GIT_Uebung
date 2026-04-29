### Datum: 29.04.2026
### Inhalt: Luftbildanalyse
### Autor/Autorin: Michael Strohbach

# Einlesen der Rasterdaten -----------------------------------------------------

# install.packages("terra")
library(terra)

# wir laden eine Datei ein
luftbild <- rast("607000-5800000.tif")

# wir benennen die Farbkanäle korrekt
names(luftbild) <- c("R", "G", "B", "NIR")

# wir plotten das Luftbild
plotRGB(luftbild)

# wir plotten ein Falsch-Farben-Bild
plotRGB(luftbild, r=4, g=2, b=3)



# Wir lesen die Punktdaten ein-------------------------------------------------------------
library(readxl)
library(sf)

Trainingspunkte <- read_xlsx("Trainingspunkte.xlsx", sheet = 1)

# ich mag das tibble-Format nicht
Trainingspunkte <- as.data.frame(Trainingspunkte)

# wir machen einen räumlichen Datensatz aus der Tabelle 
Trainingspunkte_sf <- st_as_sf(Trainingspunkte, coords = c("lon", "lat"), crs=4326) 

# wir Projezieren die Daten auf das selbe Koordinatensystem wie die Rasterdaten
Trainingspunkte_sf <- st_transform(Trainingspunkte_sf, crs = st_crs(luftbild))

# plot der Luftbilder mit den Punkten
plotRGB(luftbild)
plot(st_geometry(Trainingspunkte_sf), add=T, pch=7, col="lightblue", lwd=2)
