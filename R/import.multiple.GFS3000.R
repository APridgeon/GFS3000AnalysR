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
#' @param files list of file paths to GFS3000 .csv files
#' @param names list of names
#' @param time0s optional list of strings corresponding to desired time 0 - must be in "2021-3-18 09:00:00" format. Adds a column "TimeNo" with time in mins.
#' @return A dataframe containing data from all of the GFS3000 runs
#' @examples
#' #basic usage of import.multiple.GFS3000
#'
#' DF1 = import.multiple.GFS3000(c("file1.csv", "file2.csv"), name=c("Col-0","Col-0"), time0s=c("2019-11-19 09:00:00","2019-11-19 09:00:00"))


#' @export
import.multiple.GFS3000 <- function(files, names, time0s=NA){

  dataframes = lapply(c(1:length(files)), FUN= function(x){
    dataframe = read.csv(files[x], fileEncoding = "latin1", sep = ";")
    dataframe = dataframe[-c(1),]
    dataframe$Name = names[x]
    dataframe$DateTime = as.POSIXct(strptime(paste(dataframe$Date, dataframe$Time), format = "%Y-%m-%d %H:%M:%S"))


    if(is.na(time0s) != TRUE){
      dataframe$TimeNo = as.numeric(difftime(dataframe$DateTime, strptime(time0s[x], format = "%Y-%m-%d %H:%M:%S"), units = "mins"))
    }

    return(dataframe)
  })

  dataframe = do.call(rbind, dataframes)

  #ensure columns are properly formatted
  dataframe$Object = as.numeric(as.character(dataframe$Object))
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

  dataframe
}
