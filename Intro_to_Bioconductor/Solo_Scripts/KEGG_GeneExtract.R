library(tidyverse)
library(KEGGREST) #Install via Bioconductor if not done so already

Kegg_genes <- keggGet("mmu04810")[[1]]$GENE 
#inside keggGET is the pathway ID for this example it is Regulation of Actin cytoskeleton

Kegg_genes <- Kegg_genes[seq(2,length(Kegg_genes),2)]
Kegg_genes <- gsub("\\;.*","", Kegg_genes)

#Read in Gene Files, note txt files maybe different
old <- read.csv("old.txt", header = FALSE)$v1
oldest <- read.csv("oldest.txt", header = FALSE)$v1

#Overlap with Old
old_intersect<- intersect(Kegg_genes,old)

#Overlap with oldest
oldest_intersect<- intersect(Kegg_genes, oldest)

#Read in Log2Files for Differential express Genes
oldg <- read.csv("Oldk.csv")
gerg <- read.csv("Ger.csv")

#Extract Genes that Overlap
Old_overlap <- oldg %>% 
  filter(mgi_symbol %in% old_intersect) %>% select(log2FoldChange,mgi_symbol)
Ger_overlap<- gerg %>% 
  filter(mgi_symbol %in% oldest_intersect) %>% select(log2FoldChange,mgi_symbol)

#Write out CSV files
write.table(cbind(Old_overlap$mgi_symbol,Old_overlap$log2FoldChange),
            file="delold.txt", sep="\t", row.names=FALSE, col.names=FALSE)
write.table(cbind(Ger_overlap$mgi_symbol,Ger_overlap$log2FoldChange),
            file="delger.txt", sep="\t", row.names=FALSE, col.names=FALSE)
