A <- read.csv("TeilmatrixGroesse.csv")
B <- read.csv("ZeitTeil.csv")
C <- read.csv("ZeitOriginal.csv")

pdf("PC.pdf")

plot(B$b ~ A$a,  col = "red",
		xlab = "Grösse der Teilmatrizen",
		ylab = "Bearbeitungseit [s]",
		main = "Notebook",
		ylim=c(5,10))
		points(C$c ~ A$a,col="green")
		
		legend(300 , 9, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()
