a <- commandArgs()
i <- a[6]
o <- a[7]

Png <- function(..., width=8, height=8, res=300){
  png(..., width=width*res, height=height*res, res=res)
}

counts <- read.table(file=i, header=F)

Png(o)
par(mar=c(10,5,1,1))
plot(counts[,2], counts[,1], las=2)

