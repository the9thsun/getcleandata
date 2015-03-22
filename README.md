# getcleandata
For submitting Assigment with Getting and Cleaning Data Coursera course

03/21/2015

Files in repository - 


1. Codebook: codebook.MD
  Describes variables created from script.


2. run_analysis.R

Purpose: to merge training and test sets to create one dataset. 
Reorganizes and collapses all 10299 observations to provide information on 30 subjects (21 training, 9 test) during 6 activities. 

Extracted only the features from the 561-feature vector that are Means or standard deviations.

Steps of run_analysis
1. Merges subject ID and activity information with measurements for test and training datasets
2. Uses regular expressions to subset mean and sd variables out of datasets - total of 86 
3. Merges test and training datasets by all remaining columns
4. Renames activity variable values
5. Melts and casts dataset to get average values of variables for each subject ID and activity pairing
6. Outputs tidy dataset to text file
 

Dataset:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

-----------------------------------

