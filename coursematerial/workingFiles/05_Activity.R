bAll
#density
sampLoc_region

e = extract(bAll, sampLoc_region)
str(e)
sampLoc_region_new2 = merge(sampLoc_region, e, by.x=c('rowid'), by.y=c('id.y'))

sampLoc_region_new3 = merge(sampLoc_region, e[, c(1, 6)], by.x=c('rowid'), by.y=c('id.y'))

plot(sampLoc_region_new2, "density")

