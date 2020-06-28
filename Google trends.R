install.packages("reshape2")
install.packages("ggplot2")
install.packages("gtrendsR")
install.packages("writexl")
library(gtrendsR)
library(ggplot2)
library(reshape2)
library(writexl)

#define the keywords
keyword=c("marine le pen")
#set the geographic area: FR = France
country=c("FR")
#set the time window
time=("2019-01-01 2020-06-26")
#set channels 
channel="web"
#Export destination
dest<-"C:/Users/Stanislas/Datascience/Language analytics/export.xlsx" 


#Run the query
trends=gtrends(keyword=keyword,geo=country,time=time,gprop =channel)

#select only interst over time 
time_trend=trends$interest_over_time

#Export Google data trend to Excel
write_xlsx(time_trend,dest)

#ggplot chart
plot<-ggplot(data=time_trend, aes(x=date, y=hits,group=keyword,col=keyword))+
  geom_line()+xlab('Time')+ylab('Relative Interest')+ theme_bw()+
  theme(legend.title = element_blank(),legend.position="bottom",legend.text=element_text(size=12))+ggtitle("Google Search Volume")
#Display ggplot
plot

#Plot in the base system
x<-time_trend$date
y<-time_trend$hits
plot(x,y,type="l",col="black",main="Google Search Volume", ylab="Relative interest",xlab="")

#Compute simple moving average 
install.packages("TTR")
library("TTR")
z<-SMA(y,n=3)

#Add simple moving average
lines(x,z,type="l",lty="dashed",col="blue")




