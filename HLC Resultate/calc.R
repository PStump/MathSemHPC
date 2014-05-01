A <- read.csv("TeilmatrixGroesse.csv")
B <- read.csv("ZeitTeil.csv")
C <- read.csv("ZeitOriginal.csv")

pdf("HSR.pdf")

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
