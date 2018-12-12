# sushi for genomic data visualization
# what is sushi? - r package for genomic data plotting
# BED, Bedgraph, bedpe, interaction matrices (data formats)
# Bed formats: chromosome name, chromosome start position, chromosome end position 
# Bedgraph: Bed columns + 4th column containing a value (read depth)

# sushi makes different plots like sequencing tracks, interaction plots for HiC data, gene structure plots, transcripts, manhatten plots, gene density plots
# cool features like zoomsregion() zoombox() to zoom in specific region of chromosomes 

library(Sushi)
Sushi_data <- data(package="Sushi")
Sushi_data

data(list=Sushi_data$results[,3])

# function plotBedgraph() to create 
head(Sushi_DNaseI.bedgraph)

chrom = "chr11"
chromstart = 1650000
chromend = 2350000

plotBedgraph(Sushi_DNaseI.bedgraph, chrom, chromstart, chromend, colorbycol = SushiColors(5))

# label the plot
labelgenome(chrom, chromstart, chromend, n=5, scale = "Mb")

# add text
mtext("Read Depth", side=2, line = 2.75, cex = 1, font = 2)
axis(side = 2, las=2, tcl=.2)

# plot manhatten, plotBed
p <- layout(matrix(c(1,1,1,1,
                     1,1,1,1,
                     2,2,2,2,
                     2,2,2,2,
                     3,3,3,3,
                     3,3,3,3),
                   6,4, byrow = T))

layout.show(p)

# set the margins
par(mgp=c(3,.3,0))

par(mar=c(3,4,3,2))

# genomic parameters
chrom2 = "chr 15"
chromstart2 = 73000000
chromend2 = 89500000

plotManhattan(bedfile = Sushi_GWAS.bed, pvalues = Sushi_GWAS.bed[,5], genome = Sushi_hg18_genome, cex=0.75)

labelgenome(genome = Sushi_hg18_genome, n=4, scale = "Mb",
            edgeblankfraction = 0.20)

axis(side = 2, las=2, tcl=.2)
mtext("log10(p)", side = 2, line = 1.75, cex = .75, font = 2)
labelplot("A)", "GWAS")

# zoomed in GWAS
# set the margins 
par(mar=c(0.1, 4, 2, 2))

# set the genomic regions
chrom = "chr 15"
chromstart = 60000000
chromend = 80000000
chromstart2=72000000
chromend2 = 74000000

plotManhattan(bedfile = Sushi_GWAS.bed, chrom = chrom2,
              chromstart = chromstart,
              chromend = chromend,
              pvalues = Sushi_GWAS.bed$pval.GC.DBP,
              col = SushiColors(6) (nrow(Sushi_hg18_genome))[15], 
cex=0.75) 

zoomsregion(region = c(chromstart2, chromend2),
            chrom = chrom2,
            extend = c(0.075, 1),
            wideextend = 0.2,
            offsets = c(0.0,0))


# plot bed to make density plot
# set the margins
par(mar=c(3,4,1.8,2))
chrom = "chr 15"
chromstart = 60000000
chromend = 80000000
chrom_biomart=gsub("chr", "", chrom)

# set the mart
mart <- useMart(host = "may2009.archive.ensembl.org",
                biomart = "ENSEMBL_MART_ENSEMBL",
                dataset = "hsapiens_gene_ensembl")

# get gene info
geneinfobed <- getBM(attributes = c("chromosome_name", "start_position", "end_position"), 
                     filters = c("chromosome_name", "start", "end"),
                     values = list(chrom_biomart, chromstart, chromend),
                     mart = mart)

geneinfobed[,1] = paste("chr", geneinfobed[,1],
                         sep = "")
plotBed(beddata = geneinfobed[!duplicated(geneinfobed),],
        chrom = chrom,
        chromstart = chromstart,
        chromend = chromend,
        row = "supplied",
        palettes = list(SushiColors(7)), 
        type = "density")



