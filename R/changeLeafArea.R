#' Change Leaf Area
#'
#' Change leaf area and recalculate gas exchange parameters
#'
#'
#' @param dataframe A GFS3000 dataframe
#' @param leafArea the new leaf area
#' @param objectNo the object number of the run of interest
#' @return returns a dataframe with updated GH2O, E, A, and ci values
#' @export
changeLeafArea <- function(dataframe, leafArea, objectNo) {

  #The Von C and Farqhuar 198~ paper and the GFS3000 manual are helpful in understanding these equations

  #Changing leaf area
  dataframe$Area[dataframe$Object == objectNo] = leafArea

  #Converting values
  m2Area = dataframe$Area/10000
  flowmmolm2s1 = dataframe$Flow/1000
  dH2OMP_perc = dataframe$dH2OMP/1000000
  dH2OZP_perc = dataframe$dH2OZP/1000000
  wa_perc = dataframe$wa/1000000
  VPD = dataframe$VPD/1000

  dC2OMP_perc = dataframe$dCO2MP/1000000
  dC2OZP_perc = dataframe$dCO2ZP/1000000
  ca_perc = dataframe$ca/1000000


  #Transpiration (E)
  dataframe$E = ((flowmmolm2s1 * (dH2OMP_perc - dH2OZP_perc))/(m2Area * (1- (wa_perc))))

  #H2O conductance (GH2O)
  dataframe$GH2O = dataframe$E/VPD

  #Photosynthetic assimilation (A)
  dataframe$A = (((flowmmolm2s1 * (dC2OZP_perc - dC2OMP_perc))/(m2Area)) - (dataframe$E * ca_perc)) * 1000

  #Intercellular CO2 concentration (ci)
  GCO2 = dataframe$GH2O/1.56
  dataframe$ci = ((((GCO2 - (dataframe$E/2)) * ca_perc) - (dataframe$A/1000)) / (GCO2 + (dataframe$E/2))) * 1000000

  #return
  dataframe
}
