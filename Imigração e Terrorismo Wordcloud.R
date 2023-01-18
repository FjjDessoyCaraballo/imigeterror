#Set your working directory

setwd()

#Load the following libraries. In case they are missing, make sure to install.

library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(dplyr)
library(data.table)
library(grDevices)
library(readxl)
library(tm)

#Source the txt file using one of two first methods

text <- read.delim()
#text <- read.delim(file.choose())
docs <- Corpus(VectorSource(text))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, removeWords, c("que", "não", "tem","por","com","uma","para","dos","mais","isso","foi","ser","são",
                                    "como","diz","esse","mas","onde","aqui","essa","quando","eles","todos","nas","lá",
                                    "pra","mesmo","só","estava","mesma","sua","suas","quem","sem","ele","está","bem","vai",
                                    "hoje","há","muito","até","tudo","seu","assim","além","ainda","agora","tá","pelo","pelos",
                                    "lugar","das","depois","fazer","nada","nem","seus","ter","todo","vocês","algum","aos",
                                    "apenas","cada","coisa","concordo","dá","essas","esses","este","nao","pela","ninguém","pode",
                                    "qual","sendo","sobre","também","tbm","aí","cair","alguém","apareceu","viu","vão","toda","será",
                                    "🕦")) 

#Turn document into matrix for wordclouding

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

#Check the words to avoid words that are not part of the analysis

head(d, 100)

#Final step is to execute the wordcloud visualization

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

