A <- read.csv("TeilmatrixGroesse.csv")
B <- read.csv("ZeitTeil.csv")
C <- read.csv("ZeitOriginal.csv")
D <- read.csv("ZeitTeil1.csv")
E <- read.csv("ZeitOriginal1.csv")

pdf("Ver.pdf")

plot(B$b ~ A$a,  col = "red",pch=4,
		xlab = "Grösse der Teilmatrizen",
		ylab = "BearbeitungsZeit [s]",
		main = "Vergleich",
		ylim=c(5,27))
		points(C$c ~ A$a,col="green",pch=4)
		points(D$d ~ A$a,col="blue")
		points(E$e ~ A$a,col="black")
		
		legend(300 , 25, c("HLC Zeit Original", "HLC Zeit Bearbeitet", "Zeit Original", "Zeit Bearbeitet"),
		col=c(3, "red" , "black", "blue"),pch = c(4,4,1,1))

		

grid()
graphics.off()
