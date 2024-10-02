### week 6 classwork/lect. a -RMarkdown-
## what is it? metadata and outputs, Markdown text, code chunks
### Created by Kyle Bosworth
### updated on 10/1/2024


#load libraries
library(tidyverse)
library(lubridate)
library(here)
library(rmarkdown)
library(tinytex)

# Review: If I want to convert Feb 28 2021 10:05:50 to a date, what function do I use?

mdy_hms("Feb 28 2021 10:05:50")
#[1] "2021-02-28 10:05:50 UTC"


## What is R Markdown?

# "An authouring framework for data science"
# a document format (.Rmd)
# An R package named rmarkdown.
# "A file format for making dynamic documents with R."
# "A tool for integrating text, code, and results."
# "A computational document."
# Wizardry. (🧙‍️)

# you can take notes in the same place as your code (source to output)



# RMarkdown is broken into 4 major parts:
## Metadata
## Text
## Code
## Output

# Metadata: YAML
# ---
# Key: value
# ---
## This goes at the top of your RMarkdown document, includes the metadata, style, and type of output for your document.
##You only need two pieces for it to work, but there is lots more to add to make it beautiful.
# title is the title of your markdown document
# output is the format that it will be saved as
# ---
# Title: "My Awesome Markdown File"
# outputs: html_document
# ---

install.packages("rmarkdown")
install.packages("tinytex") #helpful if you want to make a .pdf

# Code chunks
# You can control what you want printed in the html within the code chunks.

# include = FALSE prevents code and results from appearinf in the finished file.
##Rmark down still runs the code in the chunk, and the results can be used by the other chunks

# echo = FALSE prevents code, but not the results from appearinf in the finished file. useful to embed figures
# 


install.packages("beepr")
library(beepr)
beep(8)


