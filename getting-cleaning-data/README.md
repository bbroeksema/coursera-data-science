# Instructions

The analysis process consists of two parts. The first part is data retrieval and
extraction. This is dealt with by the retrieve_data.R script. To retrieve the
data perform the following steps:

1. Set the working directory to the directory that contains the retrieve_data.R
   and the run_analysis.R scripts.
2. Run the following command: > source('retrieve_data.R')
3. Run the following command: > retrieveData()

Optionally, there is the cleanData() function which removes all downloaded data
after which retrieveData() can be called to start with a clean slate.

The second part consist of merging the test and training data, and to create the
summary data set. This is implemented in the run_analysis.R script.

> source('run_analysis.R')

The resulting summary data is stored in: data/variable_average_per_subject.csv
