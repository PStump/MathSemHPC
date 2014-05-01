A <- read.csv("TeilmatrixGroesse1000.csv")
B <- read.csv("ZeitTeil1000.csv")
C <- read.csv("ZeitOriginal1000.csv")

pdf("HSR1000.pdf")

plot(B$b ~ A$a,  col = "red",
		xlab = "Grösse der Teilmatrizen",
		ylab = "Bearbeitungszeit [s]",
		main = "Hochleistungscomputer",
		ylim=c(9,27))
		points(C$c ~ A$a,col="green")
		
		legend(300 , 25, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()
