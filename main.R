# Import Libraries

# library(devtools)
# install_github("nurandi/katadasaR")

library(textclean)
library(tokenizers)
library(dplyr)
library(tidyverse)
library(stringr)
library(tm)
library(knitr)
library(tidytext)
library(katadasaR)

# Import dataset
raw_tweets = readr::read_csv("crypto_tweets.csv")

# import indonesian stopwords
id_stopwords = readLines("indonesia_stopwords.txt")

# Preprocessing
tweets = raw_tweets %>%
  # drop unused columns
  within(rm(X1, Username, PostDate, TweetURL, clean_text)) %>%
  # remove duplicate tweets
  distinct(TweetText, .keep_all=TRUE) %>%
  # lower text
  mutate(TweetText = tolower(TweetText)) %>%
  # text stripping
  mutate(TweetText = strip(TweetText)) %>%
  # remove digits
  mutate(TweetText = str_replace_all(TweetText, "[[:digit:]]", " ")) %>%
  # remove punctuations
  mutate(TweetText = str_replace_all(TweetText, "[[:punct:]]", " ")) %>%
  # remove extra spacing
  mutate(TweetText = replace_white(TweetText)) %>%
  # remove english stopwords
  mutate(TweetText = removeWords(TweetText, stopwords("english"))) %>%
  # tokenize and remove stopwords for each row
  mutate(Tokens = tokenize_words(TweetText, stopwords=id_stopwords)) 


# function to join words
join_words <- function(word_list) {
  return(paste(word_list, sep='', collapse=' '))
}


tweets2 = tweets %>%
  # join tokens
  mutate(cleaned = lapply(Tokens[], join_words)) %>%
  # remove tweet/sentence that contain less than 3 words
  filter(count_words(cleaned[]) >= 3)

# create bigrams
tweets3 = tweets2 %>%
  select(cleaned) %>%
  unnest_tokens(bigram, cleaned, token="ngrams", n=2)

# filter and count how many times a unique bigram appears
bigrams = tweets3 %>%
  group_by(bigram) %>%
  summarise(n = n())

# filter bigram whose occurrence value is more than 10
# this is done so as not to burden the network 
# that will be loaded in gephi because of the many nodes and edges 
unique_bigrams = bigrams %>%
  filter(n > 10)

# separate bigrams into source and target
pair_df = unique_bigrams %>%
  select(bigram) %>%
  separate(col=bigram, into=c('source', 'target'), sep = " ")

# load libraries to create network
library(igraph)
library(rgexf)

# create the network
d_net <- simplify(graph_from_data_frame(d = pair_df, directed = FALSE), 
                  remove.loops = TRUE, 
                  remove.multiple = FALSE) 

# save the network to graphml format
write_graph(graph = d_net, file = "crptyo-net.graphml", format = "graphml")
