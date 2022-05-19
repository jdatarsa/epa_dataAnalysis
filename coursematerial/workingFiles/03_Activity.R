df %>% 
  group_by(anim_sex) %>% 
  summarise(sum(fmd_exp_st)/n()) #check table 1 to adjust factor levels

df.sex = table(df$anim_sex, df$fmd_exp_st)

epi.conf(as.matrix(cbind(df.sex[,2], rowSums(df.sex))), 
         ctype = "prevalence", 
         method = "fleiss", 
         conf.level = 0.95,
         design = D,
         N = 10000000) * 100 #here make the overarching population large


############### account for diagnostic tests 

outputListSex = list()

for (i in unique(df$anim_sex)){
  datatemp = df[df$anim_sex == i,]
  
  outputListSex[i] = epi.prev(pos = sum(datatemp$fmd_exp_st), tested = nrow(datatemp), 
                           se = SeParrTwoTest(0.864, 0.864), 
                           sp = SpParrTwoTest(0.981, 0.974), method = "wilson",
                           units = 100, conf.level = 0.95)
}

lapply(outputListSex, print)
plyr::ldply(outputListSex, data.frame) #nice way to fit a list to dataframe

########################### Plotting
wahid_outbreaks.epiCurve.FMD = wahid_outbreaks.epiCurve
str(wahid_outbreaks.epiCurve.FMD)
wahid_outbreaks.epiCurve.FMD = subset(wahid_outbreaks.epiCurve.FMD, subset = outbreakStartDate >= '2014-01-01' & 
                                        outbreakStartDate < '2016-01-01' & 
                                        diseases == "Foot and mouth disease virus (Inf. with) ")

wahid_outbreaks.epiCurve.FMD.plot<- wahid_outbreaks.epiCurve.FMD %>%
  mutate(yearmon = as.yearmon(outbreakStartDate)) %>%
  group_by(reportInfoId, diseases, yearmon) %>%
   tally()

wahid_outbreaks.epiCurve.FMD.plot$diseases = factor(wahid_outbreaks.epiCurve.FMD.plot$diseases)
levels(wahid_outbreaks.epiCurve.FMD.plot$diseases)
levels(wahid_outbreaks.epiCurve.FMD.plot$diseases) = "FMD"

ggplot(wahid_outbreaks.epiCurve.FMD.plot, aes(x=as.Date(yearmon), y=n, fill = diseases)) + 
  geom_bar(stat='identity') +
  labs(x="Outbreak Month", y="Outbreak Count") +
  theme_bw() + 
  scale_y_continuous(limits = c(0,max(wahid_outbreaks.epiCurve.FMD.plot$n*1.5)), 
                     breaks = seq(0,max(wahid_outbreaks.epiCurve.FMD.plot$n*1.5),10)) + 
  scale_x_date(date_breaks = "1 month", date_labels =  "%b %y", 
               name = "Date") + 
  theme(axis.text.x=element_text(angle=60, hjust=1),
        panel.grid = element_blank())






