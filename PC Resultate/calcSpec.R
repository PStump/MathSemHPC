A <- read.csv("TeilmatrixGroesse1000spec25.csv")
B <- read.csv("ZeitTeil1000spec25.csv")
C <- read.csv("ZeitOriginal1000spec25.csv")

pdf("PC1000spec25.pdf")
plot(B$b ~ A$a,  col = "red",
		xlab = "max. Schlaufen der Teilmatrizen",
		ylab = "Bearbeitungseit [s]",
		main = "1000 x 1000 Matrix (Teilmatrizen 25 x 25)",
		ylim=c(2,10))
		points(C$c ~ A$a,col="green")
		
		legend(6000 , 8.5, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()



A <- read.csv("TeilmatrixGroesse1000spec250.csv")
B <- read.csv("ZeitTeil1000spec250.csv")
C <- read.csv("ZeitOriginal1000spec250.csv")

pdf("PC1000spec250.pdf")
plot(B$b ~ A$a,  col = "red",
		xlab = "max. Schlaufen der Teilmatrizen",
		ylab = "Bearbeitungseit [s]",
		main = "1000 x 1000 Matrix (Teilmatrizen 250 x 250)",
		ylim=c(2,10))
		points(C$c ~ A$a,col="green")
		
		legend(6000 , 8.5, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()