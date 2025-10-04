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

#metadata.subset <- select(metadata, c(1, 10, 11, 17))

metadata.modified <- metadata%>%
  select(1,10, 11, 17)%>%
  rename(tissue = characteristics_ch1)%>%
  rename(metastasis = characteristics_ch1.1)%>%
  mutate(tissue = gsub("tissue: ", "", tissue))%>%
  mutate(tissue = gsub("metastasis: ", "", metastasis))
#head(metadata.modified)

head(data)

#Reshaping data
data.long <- data%>%
  rename(gene = X)%>%
  gather(key = 'samples', value = 'FPKM', -gene)%>%
head()  

#join dataframes = data.long + metadata.modified

data.long%>%
  left_join(., metadata.modified, by = c("samples" = "description"))%>%
 # head()

#explore data
  
  data_joined %>%
  filter(gene %in% c("BRCA1", "BRCA2")) %>%
  group_by(gene, tissue) %>%
  summarise(mean_FPKM = mean(FPKM, na.rm = TRUE)) %>%
  arrange(gene, tissue) %>%
  head()
