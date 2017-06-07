setwd("~/Box Sync/DARTE-QM Project/mobile-elements-for-proposal/")
abund <- read.delim(sep="\t", file="summary-count.tsv", header=TRUE, strip.white=TRUE, row.names=1)
colnames(abund) <- colnames(abund)[2:13]
abund[13] <- NULL
abund$SUMS <- rowSums(abund)
abund_sort <- abund[order(-abund$SUMS),]
abund_sort$REL <- abund_sort$SUMS/7891820

#8777 unique mobile elements including plasmid, prophage, and viral from aclame database identified
x<-read.table(text=abund$id, sep=":", colClasses="character")
total <- cbind(abund, x)

 plasmid proph  vir
                   
    5732  1515 1530

setwd("~/scratch/SS_Data_Files/")
arg <- read.delim(sep=",", file="erm_class_phyla_counts.csv", header=FALSE, strip.white=TRUE)
arg$V5 <- NULL
arg$V6 <- NULL
arg2 <- subset(arg, V1 == "Manure" | V1 == "Soil")
ggplot(arg2, aes(x=V2, y=V4, fill=V3))+geom_bar(stat="identity")+facet_grid(~V1)
arg2_man <- subset(arg2, V1 == "Manure")
f=ddply(arg2_man, .(V1, V2), summarise, TOT=sum(REL))
ordering=f$V2[order(-f$TOT)]
arg2_soil <- subset(arg2, V1 == "Soil")
#manure 498537
#soil 22516
arg2_man$REL = arg2_man$V4/498537*100
arg2_soil$REL = arg2_soil$V4/22516*100

tot <- rbind(arg2_soil, arg2_man)

tot$V2 = factor(tot$V2, levels=ordering)
tot <- subset(tot, V2 != "Uncategorized")
tot <- subset(tot, V2 != "NA")
tot <- subset(tot, V3 != "uncultured_bacterium" )
tot <- subset(tot, V3 != "Plasmid" )
tot <- subset(tot, V3 != "plasmids." )
ggplot(tot, aes(x=V2, y=REL, fill=V3))+geom_bar(stat="identity")+facet_grid(~V1)+theme_bw()+theme(axis.text.x = element_text(angle = 90, hjust = 1))+ylab("Relative Abundance in Environment")+guides(fill=guide_legend(title="Phyla"))+theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank())+xlab("")
