########################################
#
#   PCA method
#
########################################

# Downloading and loading packages -----------------------------------------

pacotes <- c("plotly","tidyverse","knitr","kableExtra","PerformanceAnalytics",
             "factoextra","reshape2","psych","ggrepel")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

df <- read.table("countries of the world.csv", 
                 header = TRUE,
                 sep = ",")

#Replacing empty values
for(i in 5:ncol(df)){
  #print(sum(is.na(df[i])))
  if ((sum(df[i] == "") > 0) & (i!=9)){
    df[i][df[i] == ""] = 123123123
    df[i] <- readr::parse_number(df[i][df[i] != ""], locale = readr::locale(decimal_mark = ","))
    i_mean <- mean(df[i][df[i] != 123123123])
    df[i][df[i] == 123123123] = i_mean
  }
  else{
    if (i!=9) {
      df[i] <- readr::parse_number(df[i][df[i] != ""], locale = readr::locale(decimal_mark = ","))
    }
  }
}

view(df)

#Taking only numeric data
numericdata <- df[-2] %>%
  column_to_rownames("Country") %>%
  data.frame()
numericdata <- numericdata[-13] #Removing climate. It's not a numeric variable

#Scaling
numdata_std <- numericdata %>% 
  scale()

#Categorical data
categdata <- df[1:2] %>%
  column_to_rownames("Country")

# Correlation matrix -----------------------------------
rho <- cor(numericdata)
varnames <- c("Population", "Area", "Pop. Density", "Coastline", "Net migration",
              "Infant mortality", "GDP per capita", "Literacy", "Phones per 1000 pop.",
              "Arable (%)", "Crops (%)", "Other (%)", "Birthrate", "Deathrate",
              "Agriculture", "Industry", "Service")
colnames(rho) <- varnames
rownames(rho) <- varnames

chart.Correlation(numericdata)

# heat map from correlations
rho %>% 
  melt() %>% 
  ggplot() +
  geom_tile(aes(x = Var1, y = Var2, fill = value)) +
  geom_text(aes(x = Var1, y = Var2, label = round(x = value, digits = 2)),
            size = 4) +
  labs(x = NULL,
       y = NULL,
       fill = "Correlation") +
  scale_fill_gradient2(low = "dodgerblue4", 
                       mid = "white", 
                       high = "brown4",
                       midpoint = 0) +
  theme(panel.background = element_rect("white"),
        panel.grid = element_line("grey95"),
        panel.border = element_rect(NA),
        legend.position = "right",
        axis.text.x = element_text(angle = 45, hjust=0.95),
        axis.text.y = element_text(angle = 0))


# Running PCA:
afpc <- prcomp(numdata_std)
summary(afpc)

#I will take 6 factores, corresponding to 78% of the data variability.

# afpc components:
afpc$sdev ^2
afpc$rotation
afpc$center

varnames <- c("Population", "Area (sq. mi.)", "Pop. Density (per sq. mi.)",
              "Coastline (coast/area ratio)", "Net migration", "Infant mortality (per 1000 births)",
              "GDP ($ per capita)", "Literacy (%)", "Phones (per 1000)", "Arable (%)", "Crops (%)",
              "Other (%)", "Birthrate", "Deathrate", "Agriculture", "Industry", "Service")

#Viewing the weights that each variable has in each main component
#obtained by the PCA (corresponding to the eigenvectors)
data.frame(afpc$rotation[,1:6]) %>%
  mutate(var = varnames) %>% 
  melt(id.vars = "var") %>%
  mutate(var = factor(var)) %>%
  ggplot(aes(x = var, y = value, fill = var)) +
  geom_bar(stat = "identity", color = "black") +
  facet_wrap(~variable) +
  labs(x = NULL, y = NULL, fill = "Legenda:") +
  scale_fill_viridis_d() +
  theme_bw()

factors <- afpc$x[, 1:6]
view(factors)

# All factors related to each country are extracted and saved in the variable factors


########################################
#
#   Clustering Analysis with K-means method
#
########################################

# Importing important libraries
library(tidyverse) #pacote para manipulacao de dados
library(cluster) #algoritmo de cluster
library(dendextend) #compara dendogramas
library(factoextra) #algoritmo de cluster e visualizacao
library(fpc) #algoritmo de cluster e visualizacao
library(gridExtra) #para a funcao grid arrange
library(readxl)

#Visualizing ELBOW method
fviz_nbclust(numdata_std, FUN = hcut, method = "wss")

#Now let's run from 3 to 6 centers and see what is the best division
numdata_std.k3 <- kmeans(numdata_std, centers = 3)
numdata_std.k4 <- kmeans(numdata_std, centers = 4)
numdata_std.k5 <- kmeans(numdata_std, centers = 5)
numdata_std.k6 <- kmeans(numdata_std, centers = 6)

#Graphs
G1 <- fviz_cluster(numdata_std.k3, geom = "point", data = numdata_std) + ggtitle("k = 3")
G2 <- fviz_cluster(numdata_std.k4, geom = "point",  data = numdata_std) + ggtitle("k = 4")
G3 <- fviz_cluster(numdata_std.k5, geom = "point",  data = numdata_std) + ggtitle("k = 5")
G4 <- fviz_cluster(numdata_std.k6, geom = "point",  data = numdata_std) + ggtitle("k = 6")

grid.arrange(G1, G2, G3, G4, nrow = 2)

#Graph
fviz_cluster(numdata_std.k5, geom = "point",  data = numdata_std) + ggtitle("k = 5")

#Binding the clusters to the dataset
countries_fit <- data.frame(numdata_std.k5$cluster)
Countries_final <- cbind(numericdata, countries_fit)

# Descriptive analysis with averages
averages <- Countries_final %>% 
  group_by(numdata_std.k5.cluster) %>% 
  summarise(n = n(),
            Population = mean(Population),
            area = mean(Area..sq..mi..),
            Pop_dens = mean(Pop..Density..per.sq..mi..),
            Coastline = mean(Coastline..coast.area.ratio.),
            Net_migration = mean(Net.migration),
            Infant_mortality = mean(Infant.mortality..per.1000.births.),
            GDP_per_capita = mean(GDP....per.capita.),
            Literacy_percentage = mean(Literacy....),
            Phones_per_thousand = mean(Phones..per.1000.),
            Arable_percentage = mean(Arable....),
            Crops_percentage = mean(Crops....),
            Other_percentage = mean(Other....),
            Birthrate = mean(Birthrate),
            Deathrate = mean(Deathrate),
            Agriculture = mean(Agriculture),
            Industry = mean(Industry),
            Service = mean(Service)
            )
view(averages)

########################################
#
#   correspondence analysis
#
########################################

#Packages
pacotes <- c("plotly","tidyverse","ggrepel","sjPlot","reshape2","knitr",
             "kableExtra","FactoMineR")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

#Now, the variable categdata has the cluster informations
categdata <- cbind(categdata, countries_fit)
view(categdata)

#Creating a contingency table
tab <- table(categdata$Region, 
             categdata$numdata_std.k5.cluster)

#Chi² test
qui2 <- chisq.test(tab)
qui2

#Exemplo de uma tabela de contingências mais elegante
colnames(categdata) = c("Region", "Cluster")
sjt.xtab(var.row = categdata$Region,
         var.col = categdata$Cluster)


cor_analysis <- CA(tab)


#Repetindo o mapa de calor dos resíduos padronizados ajustados
data.frame(qui2$stdres) %>%
  rename(perfil = 1,
         aplicacao = 2) %>% 
  ggplot(aes(x = fct_rev(perfil), 
             y = aplicacao, 
             fill = Freq, 
             label = round(Freq,3))) +
  geom_tile() +
  geom_label(size = 3, fill = "white") +
  scale_fill_gradient2(low = "dodgerblue4", 
                       mid = "white", 
                       high = "brown4",
                       midpoint = 0) +
  labs(x = NULL, y = NULL) +
  coord_flip() +
  theme(legend.title = element_blank(), 
        panel.background = element_rect("white"),
        legend.position = "none",
        axis.text.y = element_text(angle = 0, hjust=0.0, vjust = 0),
        axis.text.x = element_text())

