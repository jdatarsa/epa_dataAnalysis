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