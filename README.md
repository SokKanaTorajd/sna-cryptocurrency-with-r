# Social Network Analysis with R and Gephi
Indonesian Cryptocurrenct Tweets. <br>
Similar with https://github.com/SokKanaTorajd/gemastik21 without Topic Modelling. 

# Dataset 
Use same dataset from https://www.kaggle.com/wijatama/indonesiancryptotweets. <br>

# Indonesian Stopwords
Combines Sastrawi's stopwords and <a href="https://github.com/masdevid/ID-Stopwords">Mas Devid's</a> Stopwords and extra stopwords from myself.<br>

# Workflow Process
0. Make sure your RStudio and Gephi are installed. Gephi download <a href="https://gephi.org/users/download/">here.</a>
1. Download the dataset.
2. Install required packages such as nurandi/kataDasar, etc and import the libraries
3. Import dataset and stopwords.
4. Preprocessing (remove duplicate tweets, text lowering, stripping, tokenizing then remove EN and ID stopwords.
5. Rejoin the tokens then remove tweets that contain less than 3 words.
6. Create and filter bigrams. I only use bigram that appears more than 10 times.
7. Separate bigram into source and target.
8. Import required libraries for creating the network.
9. Create and save the network.
10. Open Gephi. Load the graphml file, then feel free to explore visualization you want.

# References
Teached by: <a href="https://github.com/eppofahmi">Ujang Fahmi</a> and
<a href="http://rstudio-pubs-static.s3.amazonaws.com/461333_4a26820bb8ea4084be104a8ffb67511b.html">Text Cleaning Bahasa Indonesia</a>

