A <- read.csv("TeilmatrixGroesse1000.csv")
B <- read.csv("ZeitTeil1000.csv")
C <- read.csv("ZeitOriginal1000.csv")

pdf("PC1000.pdf")
plot(B$b ~ A$a,  col = "red",
		xlab = "Grösse der Teilmatrizen",
		ylab = "Bearbeitungseit [s]",
		main = "1000 x 1000 Matrix",
		ylim=c(5,10))
		points(C$c ~ A$a,col="green")
		
		legend(300 , 9, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()

A <- read.csv("TeilmatrixGroesse100.csv")
B <- read.csv("ZeitTeil100.csv")
C <- read.csv("ZeitOriginal100.csv")

pdf("PC100.pdf")

plot(B$b ~ A$a,  col = "red",
		xlab = "Grösse der Teilmatrizen",
		ylab = "Bearbeitungseit [s]",
		main = "100 x 100 Matrix",
		ylim=c(0,1))
		points(C$c ~ A$a,col="green")
		
		legend(300 , 9, c("Zeit Original", "Zeit Bearbeitet"),
		col=c("green", "red"),pch = c(1,1))

grid()
graphics.off()

# plots für 10000x10000 ylim= muss noch angepasst werden

 A <- read.csv("TeilmatrixGroesse10000.csv")
 B <- read.csv("ZeitTeil10000.csv")
 C <- read.csv("ZeitOriginal10000.csv")

 pdf("PC10000.pdf")

 plot(B$b ~ A$a,  col = "red",
		 xlab = "Grösse der Teilmatrizen",
		 ylab = "Bearbeitungseit [s]",
		 main = "10000 x 10000 Matrix",
		 ylim=c(0,2000))
		 points(C$c ~ A$a,col="green")
		
		 legend(3500 , 1500, c("Zeit Original", "Zeit bearbeitet"),
		 col=c("green", "red"),pch = c(1,1))

 grid()
 graphics.off()


