#How to manipulate gene expression (RNA-Seq) matrix in R using dplyr
#setwd("~/Bioinformatics101/scripts")

#Script to manipulate gene expression data

#load libraries
library(dplyr)
library(tidyverse)
library(GEOquery)

#read in the data
data <- read.csv(file = "../data/GSE183947_fpkm.csv")
dim(data)

#get metadata
gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072*1000)
gse

metadata <- pData(phenoData(gse[[1]]))
head(metadata)

