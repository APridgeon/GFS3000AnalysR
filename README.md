# GFS3000AnalysR

An R package to import GFS3000 .csv files into R and recompute gas exchange parameters upon changing the leaf area.

This is designed with stomatal conductance timecourse experiments in mind.

## Installation

You can install this in R using the `devtools::install_github()` function

```r
devtools::install_github("APridgeon/GFS3000AnalysR")
```

## Usage

Check the introduction vignette for examples showing use of the package functions.

### In short

* Use `import.single.GFS3000()` or `import.multiple.GFS3000()` to import data.
* Use `changeLeafArea()` to change leaf areas and recompute gas exchange parameters
