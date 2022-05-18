#Activity 1 - Intro
ages <-  c(39,40,36,44,48,40,58,42,42,34,42,50)
attendess <- c("john", "idy", "pearl", "catherine", "sechele", "pretty", "alec", "obakeng", "owen", 'tt', "lule", "eb")
names(ages) <- attendess
ages
summary(ages)
boxplot(ages)
hist(ages)

#1b: Cattle
wahid_species <- read.csv("https://epicpd.jshiny.com/jdata/epicpd/botswanaVS/coursematerial/tabular/wahid_botswana_specieslevel.csv")
wahid_species_new <-wahid_species[wahid_species$spicieName == 'Cattle' & wahid_species$totalNcase > 10, ]
wahid_species_new2 <- subset(wahid_species, subset = spicieName == 'Cattle'& totalNcase > 10)

nrow(wahid_species_new)
nrow(wahid_species_new2)

wahid_species_new == wahid_species_new2

wahid_species_new2

seq(1,50,2)

## Random sampling 5%
farmsInBotswana<-c(1:20000)
NFarms <- length(farmsInBotswana)
propoAudit <- 0.002

numberToSample <- NFarms*propoAudit

sample(farmsInBotswana, size = numberToSample)

set.seed(27)
sample(farmsInBotswana, size = numberToSample)

set.seed(8)
dataset <- rnorm(1000000, mean = 15, sd = 2)
mean(dataset)
