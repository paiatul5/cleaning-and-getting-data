# cleaning-and-getting-data

1. First the data set was donloaded from the given url using the download.file method
2. The data was unzipped 
3. The main folder was accessed, features.txt was converted to data frame; using the grepl function only the features having mean and std were found and the row numbers were saved
4. activity_labels.txt file was accessed, converted to data frame, the match between the labels and activity was stored in a data frame
5. test folder was accessed, from the x_test.txt only the required columns were selected using the saved data from features.txt
6. the activity column and subject columns were appended appropriately using the y_test.txt and subject_test.txt
7. Similar steps were followed for the train data
8. the train and test datasets were merged into a single data frame
9. using the data.table module; the necessary transformations were made using melt and dcast methods to get the mean of the variables
