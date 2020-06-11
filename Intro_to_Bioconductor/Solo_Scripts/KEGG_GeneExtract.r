library(KEGGREST) #Install via Bioconductor if not done so already

Kegg_genes <- keggGet("mmu04810")[[1]]$GENE 
#inside keggGET is the pathway ID for this example it is Regulation of Actin cytoskeleton

Kegg_genes <- Kegg_genes[seq(2,length(Kegg_genes),2)]
Kegg_genes <- gsub("\\;.*","", Kegg_genes)

#Read in Gene Files, note txt files maybe different
old <- read.csv("old.txt", header = FALSE)
oldest <- read.csv("oldest.txt", header = FALSE)

#Overlap with Old
intersect(Kegg_genes,old)

#Overlap with oldest
intersect(Kegg_genes, oldest)
