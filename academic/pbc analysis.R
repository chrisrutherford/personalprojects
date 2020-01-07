library("survival")
library("ggplot2")
library("ggfortify")
library("survminer")

udca_data<-udca1
attach(udca_data)
head(udca_data)
udca_data$surv=Surv(time = futime,
                    event=status==1)

plot(x=udca_data$surv,
     col='red',
     main="Overall survival of patients",
     xlab="Survival time (days)",
     ylab="Survival probability",
     mark.time=T)

## for log plotting purposes
udca_data_nozeros=udca_data[udca_data$futime>0,]

# Data from a trial of ursodeoxycholic acid (UDCA)
# in patients with primary biliary cirrohosis (PBC).
# Variables ----
# id - subject identifier
# trt - treatment of 0=placebo, 1=UDCA
# stage - stage of disease
# bili - bilirubin level at study start
# riskscore - Mayo PBC risk score at entry
# futime - survival time in days
# status - 0/1 censored/death

# fitting a survival object by treatment type to plot KM curves ----
udca_trt=survfit(surv~trt,data = udca_data)
udca_trt

# KM curves for treatment type ----
ggsurvplot(fit=udca_trt,
           data=udca_data,
           conf.int = T,
           conf.int.alpha=0.15,
           title="Survival of patients by treatment type",
           
           censor=T,
           risk.table = T,
           surv.median.line = "hv",
           
           legend.labs=c("Placebo","UDCA"),
           legend.title="Treatment",
           break.time.by=250,
           pval = T,
           palette = c("blue","red"),
           ggtheme = theme_light())
survdiff(surv~trt,
         data=udca_data)

# KM curve for stages ----
udca_stage=survfit(surv~stage,
                   data=udca_data)

udca_stage
ggsurvplot(fit=udca_stage,
           data=udca_data,
           title="Survival of patients by disease stage",
           pval = T,
           conf.int = T,
           conf.int.alpha=0.15,
           censor=T,
           surv.median.line = "hv",
           legend.labs=c("0","1"),
           legend.title="Stage",
           palette = c("purple","red"),
           risk.table = T,
           ggtheme=theme_light(),
           break.time.by=250
           )
survdiff(surv~stage,
         data=udca_data)


# KM curves for bilirubin levels ----
udca_bili=survfit(formula = surv~bili>1.2,
                  data = udca_data)
udca_bili
ggsurvplot(fit=udca_bili,
           title="Survival of patients by bilirubin levels",
           conf.int = T,
           conf.int.alpha=0.15,
           censor=T,
           surv.median.line = 'hv',
           pval = T,
           legend.labs=c("<=1.2",">1.2"),
           legend.title="Bilirubin level",
           palette = c("skyblue4","springgreen4"),
           risk.table = T,
           ggtheme = theme_light(),
           break.time.by=250)
survdiff(formula = surv~bili>1.2,
         data = udca_data)

# histograms and boxplots for bilirubin by treatment group ----
layout(matrix(c(1,2,3,3),ncol=2,byrow = T))
hist(x = udca_data[udca_data$trt==0,]$bili,
     breaks = 15,
     col="skyblue4",
     xlab="Bilirubin level",
     main="Histogram of bilirubin level (placebo group)",)
hist(x = udca_data[udca_data$trt==1,]$bili,
     breaks = 15,
     col="springgreen4",
     xlab="Bilirubin level",
     main="Histogram of bilirubin level (treatment group)")
boxplot(formula=bili~as.factor(trt),
        data = udca_data,
        main="Boxplot of bilirubin level by treatment group",
        ylab = "Treatment type",
        xlab="Bilirubin level",
        names=c("Placebo","Treatment"),
        col=c("skyblue4","springgreen4"),
        horizontal = T)
layout(matrix(1))

# bilirubin
summary(udca_data[udca_data$trt==0,4])
summary(udca_data[udca_data$trt==1,4])

# survival plots to compare strata of bilirubin levels ----
bili_data_hi=udca_data[udca_data$bili>1.2,]
bili_data_lo=udca_data[udca_data$bili<=1.2,]
bili_hi=survfit(surv~trt,
                data=bili_data_hi)
bili_lo=survfit(surv~trt,
                data=udca_data_lo)
bili_lo_plot=ggsurvplot(fit = bili_hi,
           data=udca_data_hi,
           title="High bilirubin level",
           legend.labs=c("Placebo","UDCA"),
           legend.title="Treatment",
           break.time.by=250,
           censor=F,
           palette = c("blue","red"),
           ggtheme = theme_light())
bili_hi_plot=ggsurvplot(fit = bili_lo,
           data=udca_data_lo,
           title="Low bilirubin level",
           legend.labs=c("Placebo","UDCA"),
           legend.title="Treatment",
           break.time.by=250,
           censor=F,
           palette = c("blue","red"),
           ggtheme = theme_light())
bili_plot_list=list(bili_lo_plot, bili_hi_plot)
bili_plots=arrange_ggsurvplots(bili_plot_list)



# KM curves for risk score ----
udca_risk=survfit(formula=surv~riskscore>=6,
                  data=udca_data)
udca_risk
ggsurvplot(fit=udca_risk,
           title="Survival of patients by risk score",
           conf.int = T,
           conf.int.alpha=0.2,
           censor=T,
           surv.median.line = 'hv',
           pval=T,
           legend.labs=c("<6",">=6"),
           legend.title="Risk score",
           palette = c("dodgerblue3","violetred3"),
           risk.table = T,
           ggtheme = theme_light(),
           break.time.by=250)
survdiff(formula = surv~riskscore>6,
         data = udca_data)

layout(matrix(c(1,2,3,3),ncol=2,byrow = T))
hist(x = udca_data[udca_data$trt==0,]$riskscore,
     breaks = 15,
     col="dodgerblue3",
     xlab="Risk score",
     main="Histogram of risk score (placebo group)",)
hist(x = udca_data[udca_data$trt==1,]$riskscore,
     breaks = 15,
     col="violetred3",
     xlab="Risk score",
     main="Histogram of risk score (treatment group)")
boxplot(formula=riskscore~as.factor(trt),
        data = udca_data,
        main="Boxplots of risk score by treatment group",
        ylab = "Treatment type",
        xlab="Risk score",
        names=c("Placebo","Treatment"),
        col=c("dodgerblue3","violetred3"),
        horizontal = T)
layout(matrix(1))
summary(udca_data[udca_data$trt==0,]$riskscore)
summary(udca_data[udca_data$trt==1,]$riskscore)

# survival plots to compare strata of risk scores  ----
score_data_hi=udca_data[udca_data$riskscore>=6,]
score_data_lo=udca_data[udca_data$riskscore<6,]
score_hi=survfit(surv~trt,
                 data = score_data_hi)
score_lo=survfit(surv~trt,
                 data = score_data_lo)
score_lo_plot=ggsurvplot(fit = score_lo,
                        data=score_data_lo,
                        title="Low risk score",
                        legend.labs=c("Placebo","UDCA"),
                        legend.title="Treatment",
                        break.time.by=250,
                        censor=F,
                        palette = c("blue","red"),
                        ggtheme = theme_light())
score_hi_plot=ggsurvplot(fit = score_hi,
                        data=score_data_hi,
                        title="High risk score",
                        legend.labs=c("Placebo","UDCA"),
                        legend.title="Treatment",
                        break.time.by=250,
                        censor=F,
                        palette = c("blue","red"),
                        ggtheme = theme_light())
score_plot_list=list(score_lo_plot, score_hi_plot)
score_plots=arrange_ggsurvplots(score_plot_list)

# cox PH model with all covariates ----
fit1=coxph(surv~trt+stage+bili+riskscore,
           data=udca_data)
summary(fit1)
ggforest(fit1,
         fontsize = 1,
         data=udca_data)

# GOF test for model 1 ----
cox.zph(fit1)

# observed vs expected plots ----
# treatment ----
par(mfrow=c(2,2))
mean_df_1=data.frame(t(colMeans(x = udca_data[3:5],
                              na.rm = T,dims = 1)))
plot(survfit(coxph(surv~stage+bili+riskscore+strata(trt),
                   data = udca_data),
             newdata = mean_df_1),
     col=c("blue","red"),
     lwd=3,
     conf.int = F,
     main="Observed vs expected plots by treatment",
     xlab="Time (days)",
     ylab = "Survival")
par(new=T)
plot(udca_trt,
     col=c("blue","red"),
     axes=F)
legend("bottomleft",
       legend = c("Expected (placebo)","Expected (treatment)",
                  "Observed (placebo)","Observed (treatment)"),
       lwd = c(3,3,1,1),
       col = c("blue","red","blue","red"),
       text.width = 0,
       x.intersp=0.2,
       y.intersp = 0.5,
       box.lty = 0)

# stage ----
mean_df_2=data.frame(t(colMeans(x = udca_data[c(2,4:5)],
                                na.rm = T,dims = 1)))
plot(survfit(coxph(surv~trt+bili+riskscore+strata(stage),
                   data = udca_data),
             newdata = mean_df_2),
     col=c("purple","red"),
     lwd=3,
     conf.int = F,
     main="Observed vs expected plots by stage",
     xlab="Time (days)",
     ylab = "Survival")
par(new=T)
plot(udca_stage,
     col=c("purple","red"),
     axes=F)
legend("bottomleft",
       legend = c("Expected (stage 0)","Expected (stage 1)",
                  "Observed (stage 0)","Observed (stage 1)"),
       lwd = c(3,3,1,1),
       col = c("purple","red","purple","red"),
       text.width = 0,
       x.intersp=0.2,
       y.intersp = 0.5,
       box.lty = 0)

# bilirubin ----
mean_df_3=data.frame(t(colMeans(x = udca_data[c(2,3,5)],
                                na.rm = T,dims = 1)))
plot(survfit(coxph(surv~trt+stage+riskscore+strata(bili>1.2),
                   data = udca_data),
             newdata = mean_df_3),
     col=c("skyblue4","springgreen4"),
     lwd=3,
     conf.int = F,
     main="Observed vs expected plots by bilirubin level",
     xlab="Time (days)",
     ylab = "Survival")
par(new=T)
plot(udca_bili,
     col=c("skyblue4","springgreen4"),
     axes=F)
legend("bottomleft",
       legend = c("Expected (<=1.2)","Expected (>1.2)",
                  "Observed (<=1.2)","Observed (>1.2)"),
       lwd = c(3,3,1,1),
       col = c("skyblue4","springgreen4","skyblue4","springgreen4"),
       text.width = 0,
       x.intersp=0.2,
       y.intersp = 0.5,
       box.lty = 0)

# riskscore ----
mean_df_4=data.frame(t(colMeans(x = udca_data[2:4],
                                na.rm = T,dims = 1)))
plot(survfit(coxph(surv~trt+stage+bili+strata(riskscore>=6),
                   data = udca_data),
             newdata = mean_df_4),
     col=c("dodgerblue3","violetred3"),
     lwd=2,
     lty = ("dotted"),
     conf.int = F,
     main="Observed vs expected plots by risk score",
     xlab="Time (days)",
     ylab = "Survival")
par(new=T)
plot(udca_risk,
     col=c("dodgerblue3","violetred3"),
     axes=F)
legend("bottomleft",
       legend = c("Expected (<6)","Expected (>=6)",
                  "Observed (<6)","Observed (>=6)"),
       lty = c("dotted","dotted","solid","solid"),
       lwd = c(3,3,1,1),
       col = c("dodgerblue3","violetred3","dodgerblue3","violetred3"),
       text.width = 0,
       x.intersp=0.2,
       y.intersp = 0.5,
       box.lty = 0)
par(mfrow=c(1,1))
# log-log plots for assessing PH assumption ----
# log-log plots for treatment ----
# no zeros data used because log(0) causes errors and does not plot the graphs
udca_trt_nozeros=survfit(surv~trt,
                         data=udca_data_nozeros)
loglogtrt=ggsurvplot(fit=udca_trt_nozeros,
           data=udca_data_nozeros,
           fun="cloglog",
           title="log-log survival of patients by treatment type",
           
           xlim=c(min(udca_trt_nozeros$time),
                  max(udca_trt_nozeros$time)),
           
           legend.labs=c("Placebo","UDCA"),
           legend.title="Treatment",
           xlab="Time in days (log scale)",
           
           palette = c("blue","red"),
           censor=F,
           ggtheme = theme_gray())

# log log plots for stage ----
udca_stage_nozeros=survfit(surv~stage,
                           data=udca_data_nozeros)
loglogstage=ggsurvplot(fit=udca_stage_nozeros,
           data=udca_data_nozeros,
           fun="cloglog",
           title="log-log survival of patients by disease stage",
           
           xlim=c(min(udca_stage_nozeros$time),
                  max(udca_stage_nozeros$time)),

           legend.labs=c("0","1"),
           legend.title="Stage",
           xlab="Time in days (log scale)",
           
           palette = c("purple","red"),
           censor=F,
           ggtheme = theme_gray())

# loglog plots for bilirubin levels ----
udca_bili_nozeros=survfit(surv~bili>1.2,
                          data=udca_data_nozeros)
loglogbili=ggsurvplot(fit=udca_bili_nozeros,
           data=udca_data_nozeros,
           fun="cloglog",
           title="log-log survival of patients by bilirubin level",
           
           xlim=c(min(udca_bili_nozeros$time),
                  max(udca_bili_nozeros$time)),
           
           legend.labs=c("<=1.2",">1.2"),
           legend.title="Bilirubin level",
           xlab="Time in days (log scale)",
           
           palette = c("skyblue4", "springgreen4"),
           censor=F,
           ggtheme = theme_gray())

# loglog plot for risk score ----
udca_risk_nozeros=survfit(surv~riskscore>=6,
                          data=udca_data_nozeros)
loglogrisk=ggsurvplot(fit=udca_risk_nozeros,
           data=udca_data_nozeros,
           fun="cloglog",
           title="log-log survival of patients by risk score",
           
           xlim=c(min(udca_bili_nozeros$time),
                  max(udca_bili_nozeros$time)),
           
           legend.labs=c("<=6",">6"),
           legend.title="Risk score",
           xlab="Time in days (log scale)",
           palette = c("dodgerblue3","violetred3"),
           censor=F,
           ggtheme = theme_gray())

# plot all log log plots from a list
logloglist=list(loglogtrt,
                loglogbili,
                loglogstage,
                loglogrisk)
arrange_ggsurvplots(x = logloglist,
                    nrow=2,
                    title = "log log plots")

# analyzing schoenfeld residuals to further assess PH assumption ----
ggcoxzph(fit=cox.zph(fit1),
         ggtheme = theme_light())


# add indicator column for high bilirubin level ----
for(i in 1:length(udca_data[,1])){
        if (udca_data$bili[i]>1.2){udca_data$biliHi[i]=1}
        else {udca_data$biliHi[i]=0}
}

# add indicator column for high risk score ----
# takes care of NA first then does the others
for(i in 1:length(udca_data[,1])){
        if (is.na(udca_data$riskscore[i])){udca_data$highRisk[i]=NA}
        else if (udca_data$riskscore[i]>=6){udca_data$highRisk[i]=1}
        else {udca_data$highRisk[i]=0}
}
udca_bili_bin=survfit(formula = surv~biliHi,
                      data = udca_data)

# check if model is any different with indicator variables ----
fit2=coxph(formula = surv~trt+stage+biliHi+highRisk,
           data=udca_data)
ggforest(fit2,fontsize = 1,
         data = udca_data)
# comparing the models
summary(fit2)
summary(fit1)
# PH assumption check
cox.zph(fit2)
ggcoxzph(fit = cox.zph(fit2),
         ggtheme = theme_light())

# stratified Cox models by stage ----
# indicator
fit_stage_indicator=coxph(formula = surv~trt+biliHi+highRisk+strata(stage),
                          data = udca_data)
summary(fit_stage_indicator)
summary(fit_stage_cont)

# assessment of stratified models ----
cox.zph(fit_stage_indicator)
cox.zph(fit_stage_cont)

ggcoxzph(fit = cox.zph(fit_stage_indicator),caption = "Indicator model",
         ggtheme = theme_light())
ggcoxzph(fit = cox.zph(fit_stage_cont),caption="Continuous model",
         ggtheme = theme_light())

# interaction models - indicator ----
fit_stage_interact_indicator=coxph(surv~(trt+biliHi+highRisk)*strata(stage),
                                   data = udca_data)
summary(fit_stage_interact_indicator)

# interaction models - continuous ----
fit_stage_interact_cont=coxph(surv~(trt+bili+riskscore)*strata(stage),
                              data = udca_data)
summary(fit_stage_interact_cont)
# testing Ho: no interaction
anova(fit_stage_interact_indicator,fit_stage_indicator)
anova(fit_stage_interact_cont,fit_stage_cont)

