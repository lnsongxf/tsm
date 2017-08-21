# Amended version of acf2() by D.S. Stoffer 
# Aug 2014

ac  <- function(series,max.lag=NULL,main=NULL){
   num=length(series)
   if (num > 49 & is.null(max.lag)) max.lag=ceiling(10+sqrt(num))
   if (num < 50 & is.null(max.lag))  max.lag=floor(5*log10(num))
   if (max.lag > (num-1)) stop("Number of lags exceeds number of observations")
   ACF=acf(series, max.lag, plot=FALSE)$acf[-1]
   PACF=as.numeric(pacf(series, max.lag, plot=FALSE)$acf)
   LAG=1:max.lag/frequency(series)
   minA=min(ACF)
   minP=min(PACF)
   U=2/sqrt(num)
   L=-U
   minu=min(minA,minP,L)-.01
   old.par <- par(no.readonly = TRUE)
   par(mfrow=c(1,2), mar = c(2.5,2.5,0.9,1),
       oma = c(1,1.2,1,1), mgp = c(1.5,0.6,0))
   
   old.par <- par(no.readonly = TRUE)
   par(mfrow=c(1,2), mar = c(3,3.2,0.9,1),
       oma = c(1,1.2,1,1), mgp = c(2,0.6,0), cex=0.75)
   barplot(ACF, ylab='ACF', xlab='LAG', ylim=c(minu,1), col='#e6186d', border=NA, names.arg=LAG)
    box()
    abline(h=c(0,L,U), lty=c(1,3,3), lwd = 2.5, col="darkgrey")
   barplot(PACF, ylab='PACF', xlab='LAG', ylim=c(minu,1), col='#e6186d', border=NA, names.arg=LAG)
    box()
    abline(h=c(0,L,U), lty=c(1,3,3), lwd = 2.5, col="darkgrey")

   if (is.null(main)){ }else{
     mtext(main, outer=TRUE,font=2)}
   
   on.exit(par(old.par))  
#   ACF<-round(ACF,2); PACF<-round(PACF,2)    
   res=(cbind(ACF, PACF)) 
   return(res)
   }

#acf3(rnorm(100))