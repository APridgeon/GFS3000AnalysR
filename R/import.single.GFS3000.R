#' Importing GFS3000 .csv files
#'
#' Made specifically for the lab324 University of Bristol GFS3000 machine which
#' saves csv files in a slightly odd format.
#'
#' I've made two different functions to import files;
#'
#'     1) import.single.GFS3000 - one function that assumes different runs are in the same .csv
#'     file under different object numbers.
#'
#'     2) import.multiple.GFS3000 - another function that imports a list of multiple .csv files.
#'
#'
#'
#' @param file path to GFS3000 .csv file
#' @param names optional list of strings corresponding to object numbers
#' @param time0s optional list of strings corresponding to desired time 0 - must be in "2021-3-18 09:00:00" format. Adds a column "TimeNo" with time in mins.
#' @return A dataframe containing data from the GFS3000 run
#' @examples
#' #basic usage of import.single.GFS3000
#'
#' DF1 = import.single.GFS3000("file1.csv", names=c("Col-0"), time0s=c("2019-11-19 09:00:00"))
#'
#' #usage of import.single.GFS3000 to read a file with multiple objects
#' #Here object 0001 corresponds to Col-0
#' #and object 0002 corresponds to q1124
#'
#' DF1 = import.single.GFS3000("file1.csv", names=c("Col-0","q1124"), time0s=c("2019-11-19 09:00:00","2019-11-19 12:00:00"))


#' @export
import.single.GFS3000 <- function(file, names=NA, time0s=NA){

  #read in .csv file
  dataframe = read.csv(file, fileEncoding = "latin1", sep = ";")
  dataframe = dataframe[-c(1),]

  #ensure columns are properly formatted
  dataframe$DateTime = as.POSIXct(strptime(paste(dataframe$Date, dataframe$Time), format = "%Y-%m-%d %H:%M:%S"))
  dataframe$Area = as.numeric(as.character(dataframe$Area))
  dataframe$CO2abs = as.numeric(as.character(dataframe$CO2abs))
  dataframe$dCO2ZP = as.numeric(as.character(dataframe$dCO2ZP))
  dataframe$dCO2MP = as.numeric(as.character(dataframe$dCO2MP))
  dataframe$H2Oabs = as.numeric(as.character(dataframe$H2Oabs))
  dataframe$dH2OZP = as.numeric(as.character(dataframe$dH2OZP))
  dataframe$dH2OMP = as.numeric(as.character(dataframe$dH2OMP))
  dataframe$Flow = as.numeric(as.character(dataframe$Flow))
  dataframe$Pamb = as.numeric(as.character(dataframe$Pamb))
  dataframe$Tcuv = as.numeric(as.character(dataframe$Tcuv))
  dataframe$Tleaf = as.numeric(as.character(dataframe$Tleaf))
  dataframe$Tamb = as.numeric(as.character(dataframe$Tamb))
  dataframe$Ttop = as.numeric(as.character(dataframe$Ttop))
  dataframe$PARtop = as.numeric(as.character(dataframe$PARtop))
  dataframe$PARbot = as.numeric(as.character(dataframe$PARbot))
  dataframe$PARamb = as.numeric(as.character(dataframe$PARamb))
  dataframe$rh = as.numeric(as.character(dataframe$rh))
  dataframe$E = as.numeric(as.character(dataframe$E))
  dataframe$VPD = as.numeric(as.character(dataframe$VPD))
  dataframe$GH2O = as.numeric(as.character(dataframe$GH2O))
  dataframe$A = as.numeric(as.character(dataframe$A))
  dataframe$ci = as.numeric(as.character(dataframe$ci))
  dataframe$ca = as.numeric(as.character(dataframe$ca))
  dataframe$wa = as.numeric(as.character(dataframe$wa))

  if(is.na(time0s) != TRUE){
    dataframe$TimeNo = NA
  }

  #add name column if name variable is not NA and time0 as well
  if(is.na(names) != TRUE){
    dataframe$Name = NA
    dataframe$Object = as.numeric(as.character(dataframe$Object))
    nameLength = length(names)
    for(x in c(1:nameLength)){
      dataframe$Name[dataframe$Object == x] = names[x]
      if(is.na(time0s) != TRUE){
        dataframe$TimeNo = as.numeric(difftime(dataframe$DateTime, strptime(time0s[x], format = "%Y-%m-%d %H:%M:%S"), units = "mins"))
      }
    }
  }

  dataframe
}



