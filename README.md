# Spectroscopic Data Viewer
This program opens a `.blq` file and generates conductance maps and its FFT maps from it. It also allows to easily treat and modify the images.

## Installation
**Requires MATLAB 2021b or later**.

From the [Github Repository](https://github.com/LowTemperaturesUAM/Spectroscopic_data_viewer), click `<> Code` -> `Download ZIP`.


## Overview

| Window | Description |
| --- | --- |
| blqApp            | Main App |
| Analyze           | Visualize maps and curves |
| blqReader         | Read `blq` files and create InfoStruct|
| mapsPreview       | View Real and FFT maps from newly created InfoStruct |
| EnergySym         | (WIP). View asymmetry between Energies of different sign |
| ChooseMatrixApp (Deprecated)   | Select combination (`Forth` / `Back`) of topography and IV curve|

**Work In Progress**

## To implement

- [ ] Landau level Analysis
	- [ ] Substract to a Conductance map the average curve
	- [ ] 2nd order derivative of conductance
	
- [ ] Map Videos. Select duration, frames, limits...
- [ ] Issues with Constrast Limits and Values with maps

