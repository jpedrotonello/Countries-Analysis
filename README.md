# Exploratory Country Analysis

Between May and July 2021 I studied many unsupervised data science techniques my MBA at USP.

In order to practice, I selected a Kaggle database and performed three unsupervised analyzes for the sociodemographic study of 227 countries: PCA, cluster analysis, and simple correspondence analysis.

The database contains data from 1970 to 2017 and can be found through this url-link: 

https://www.kaggle.com/fernandol/countries-of-the-world

The table below shows the first data from the database:

![](Imagens/1.png)

From the observations, it was possible to determine the Pearson correlation matrix between the variables. A heat map was made for an easier visualization of the combined behavior of the data.

![](Imagens/2.png)

The following hypothesis test was established:

__Null hypothesis__: Variables are not correlated.

__Alternativa hypothesis__: Variables are correlated.

In order to check which hypothesis will be considered, the Bartlett test can be used. The alternative hypothesis is considered with 95% confidence if the test's P-value is less than 0.05, or if the Chi² value is greater than 164 for the corresponding number of degrees of freedom.

For the Pearson matrix for this database, the P value of the test is very close to 0 and Chi² is 2580, thus adopting the hypothesis that the variables are correlated.


For the study of the covariance of the data, the PCA technique was used to extract the principal components. Only 6 factors were used, extracted from the correlation matrix of the 17 metric variables present in the database, where the 6 main factors were extracted based on Bartlett's criterion (factors related to eigenvalues ​​greater than 1) and represent 78% of the covariance of the data.

From the correlation matrix of the metric variables, the eigenvalues ​​were obtained, which are represented in the graph below:

![](Imagens/3.png)

It is observed that the principal factor (PC1), which alone represents 30% of the variability of the data, is highly influenced by sociodemographic indicators, correlating positively with service indicators, number of cell phones per 1000 inhabitants, literacy and GDP per capita, while it is very negatively correlated with indicators of agriculture, birth rate and infant mortality.
The second factor represents 14% of the data variability and is strongly correlated with the percentage of arable land and cropping rate.

# Cluster Analysis
For the clustering of countries, an elbow graph was made in order to obtain a clue about the best number of clusters.

![](Imagens/4.png)

The image below shows the cluster analysis with 3, 4, 5 and 6 groups in the Dim1 x Dim2 graph. The two dimensions together represent 44.8% of the combined variability of the data. The horizontal axis represents an indicator that takes into account sociodemographic indexes. The further to the right, the lower the illiteracy, infant mortality and birth rates and the higher the service, GDP per capita and cell phone access rates.

The higher up the graph, the higher the percentage of arable land and cropping rate.

There are 4 other factors, which correspond to a smaller percentage of the total variability of the data and are not represented in the graphs.

![](Imagens/5.png)

For the analysis, I chose to work with 5 clusters. The means of each group referring to each metric variable were extracted to facilitate the characterization of each of the 5 clusters.

![](Imagens/6.png)

Continuation
![](Imagens/7.png)

Characterization of clusters:

|     Cluster    |     Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |     Countries                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |   |   |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|---|
|     1          |     Cluster 1 is the largest of all, with 76 members. It represents countries that, on average, have a smaller area, smaller population and lower rate of migration. This cluster has the second best rate of infant mortality, literacy and access to cell phones. Being behind only cluster 5 for these indicators. On average, it has high levels of arable land, second only to cluster 4 for this indicator. They are industrialized countries, only behind cluster 3 in this regard.    |     Mexico, Mongolia, Montserrat, Morocco,   Nauru, Nicaragua, Panama, Paraguay, Peru, Philippines, Poland, Reunion,   Romania, Saint Helena, Saint Kitts & Nevis, Saint Lucia, St Pierre &   Miquelon, Saint Vincent and the Grenadines, Samoa, Serbia, Seychelles,   Slovakia, Solomon Islands, South Africa, Sri Lanka, Suriname, Syria, Thailand,   Trinidad & Tobago, Tunisia, Turkey, Tuvalu, Ukraine, Uruguay, Uzbekistan,   Vietnam and West Bank.                                                                                                                                                                                                                                               |   |   |
|     2          |     Countries with the worst rates of infant mortality, GDP per capita, illiteracy, access to cell phones, in addition to being the cluster with the highest average birth rate. These countries have the highest levels of agriculture on average.                                                                                                                                                                                                                                                                                        |     Guinea-Bissau, Kenya, Laos, Lesotho,   Liberia, Madagascar, Malawi, Mali, Mauritania, Mayotte, Mozambique, Namibia,   Nepal, Niger, Nigeria, Pakistan, Papua New Guinea, Senegal, Sierra Leone,   Somalia, Sudan, Swaziland, Tajikistan, Tanzania, Uganda, Vanuatu, Yemen,   Zambia and Zimbabwe.                                                                                                                                                                                                                                                                                                                                                                                                    |   |   |
|     3          |     On average, the countries in cluster 3 have a larger population, larger area, less population density and lesser coastline. In general, they are countries with less arable land in percentage and less cultivation, but they stand out for their industrialization and low mortality rate.                                                                                                                                                                                                                                                |     Algeria, Argentina, Bolivia, Brazil,   Brunei, Chile, China, Colombia, Congo, Repub. of the, Egypt, Equatorial   Guinea, Gabon, Indonesia, Iran, Iraq, Kazakhstan, Kuwait, Libya, Malaysia,   Oman, Puerto Rico, Qatar, Russia, Saudi Arabia, Turkmenistan, United Arab   Emirates, Venezuela and Western Sahara                                                                                                                                                                                                                                                                                                                                                                                     |   |   |
|     4          |     Represents a smaller number of countries. Cluster 4 countries have high levels of arable land and cultivation. They are countries with a high coastal extension and low industrialization.                                                                                                                                                                                                                                                                                                                                               |     Bangladesh, Burundi, Comoros, Gaza   Strip, Haiti, India, Kiribati, Maldives, Marshall Islands, Micronesia, Fed. St.,   Moldova, Rwanda, Sao Tome & Principe, Togo, Tonga and Wallis and Futuna.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |   |   |
|     5          |     Countries with the best infant mortality rates, GDP per capita, illiteracy, access to cell phones, in addition to being the cluster with the lowest average birth rate.                                                                                                                                                                                                                                                                                                                                                    |     Andorra, Anguilla, Aruba, Australia,   Austria, Bahamas, Bahrain, Barbados, Belgium, Bermuda, British Virgin Is.,   Canada, Cayman Islands, Cyprus, Denmark, Faroe Islands, Finland, France,   French Guiana, French Polynesia, Germany, Gibraltar, Greece, Guam, Guernsey,   Hong Kong, Iceland, Ireland, Isle of Man, Israel, Italy, Japan, Jersey,   Korea, South, Liechtenstein, Luxembourg, Macau, Malta, Martinique, Monaco,   Netherlands, Netherlands Antilles, New Caledonia, New Zealand, N. Mariana   Islands, Norway, Palau, Portugal, San Marino, Singapore, Slovenia, Spain,   Sweden, Switzerland, Taiwan, Turks & Caicos Is, United Kingdom, United   States and Virgin Islands.    |   |   |



# Simple Correspondence Analysis
From the countries grouped into 5 clusters, the hypothesis arises whether there is an association between these groups and the continents. To say that the association between the region and the clusters does not occur randomly, it is verified whether the P value of the Qui² test is less than 0.05.

The P value can be viewed together with the contingency table below.


![](Imagens/8.png)

The P value is less than 0.05, thus adopting the hypothesis of association between the categorical variables Region and Cluster.

Using the simple correspondence method between the two variables, a perceptual mapping was made, capable of representing 83% of the association between regions and clusters.

![](Imagens/9.png)

The proximity between cluster 2 and sub-Saharan Africa on the map suggests a strong association between the region and the cluster. The map also suggests that countries in cluster 4 are more associated with sub-Saharan Africa, Asia and Oceania than with the other regions, cluster 5 is associated with western Europe and North America and clusters 1 and 3 are associated with the north Africa, Baltic, Latin America and Caribbean, Commonwealth of Independent States, Eastern Europe and Near East.

It is important to stress that this is a suggestion of a perceptual map and that it does not represent 100% of the total inertia. We can validate or discard association hypotheses through the standardized residuals table, where the rows represent the regions and the columns represent the clusters. A value greater than 1.96 means that we can say with more than 95% of confidence level that the respective region is associated with the respective cluster.

![](Imagens/10.png)

Through the residuals table, it is possible to observe that we cannot base ourselves only on the two-dimensional perceptual mapping. Among all the associations mentioned above, we can verify that the ones that we can actually say with more than 95% of confidence level are the associations shown in the following table:

|Cluster|Association (valor p < 0.05)                               |
|-------|-----------------------------------------------------------|
|   1   |	Eastern Europe, Latin America and the Caribbean and Baltic|
|   2   |	África Subsaariana                                        |
|   3   |	North Africa and Near East                                |
|   4   |	Oceania                                                   |
|   5   |	Western Europe                                            |

Through the joint use of the techniques of PCA, Clustering and Correspondence Analysis, it was possible to study the joint behavior of the variables and indicators of the countries, group similar countries together and carry out an association of the groups of countries with the regions.

In the study, what caught my attention was the contrast between Cluster 5 and 2, associated with Western Europe and Sub-Saharan Africa, respectively. Cluster 5 has the best indicators of infant mortality, GDP per capita, illiteracy, access to cell phones, in addition to being the cluster with the lowest average birth rate. Cluster 2, associated with Sub-Saharan Africa, is the opposite in all these variables, having the worst rates and the highest average birth rate.

