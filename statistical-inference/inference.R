dose <- as.numeric(levels(as.factor(ToothGrowth$dose)))
supp <- levels(ToothGrowth$supp)

data <- list()

Map(function(s) {
  Map(function(d) {
    l <- ToothGrowth$len[ToothGrowth$dose == d & ToothGrowth$supp == s]
    data <<- rbind(data, list(supp = s, dose = d, S=sd(l), var=var(l), mu=mean(l)))
  }, dose)
}, supp)


tests = list()
for (d in dose) {
  ojd <- ToothGrowth$len[ToothGrowth$dose == d & ToothGrowth$supp == "OJ"]
  vcd <- ToothGrowth$len[ToothGrowth$dose == d & ToothGrowth$supp == "VC"]
  t <- t.test(ojd, vcd)
  print(t)
  id <- paste("OJ", d, "-", "VC", d)
  tests <- rbind(tests, list(id=id, p.value=t$p.value, ci.lo=t$conf.int[1], ci.hi=t$conf.int[2]))
}
