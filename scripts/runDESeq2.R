#Differential Gene Expression Analysis using DESeq2 Package in R

#load librabries
library(DESeq2)
library(tidyverse)
library(airway)

#Step 1: preparing count data ---------------
counts_data <- read.csv("../data/counts_data.csv")
head(counts_data)

#read in sample info
colData <- read.csv('../data/sample_info.csv')

# make sure the names in the colData matches to column names in counts_data
all(colnames(counts_data %in% rownames(colData)))

# are they in the same order?
all(colnames(counts_data) == rownames(colData))

# Step 2: construct a DESeqDataSet object ---------------
dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = colData,
                              design = ~ dexamethasone)
dds

# pre-filtering: removing rows with low gene counts
# keeping rows that have at least 10 reads total

retainData <- rowSums(counts(dds)) >= 10
dds <- dds[retainData,]

dds
 