% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/changeLeafArea.R
\name{changeLeafArea}
\alias{changeLeafArea}
\title{Change Leaf Area}
\usage{
changeLeafArea(dataframe, leafArea, objectNo)
}
\arguments{
\item{dataframe}{A GFS3000 dataframe}

\item{leafArea}{the new leaf area}

\item{objectNo}{the object number of the run of interest}
}
\value{
returns a dataframe with updated GH2O, E, A, and ci values
}
\description{
Change leaf area and recalculate gas exchange parameters
}
