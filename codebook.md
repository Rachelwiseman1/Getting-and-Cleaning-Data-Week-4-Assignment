# Existing tables
features:  list of all features.
activity_labels: links the class labels with their activity name.
X_train: Training set.
Y_train: Training labels.
X_test: Test set.
Y_test: Test labels.
subject_train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
 (there are 6 activities; WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING)
 
 # New tables

X_total: X_train and X_test combined, mean and standard deviation only.
Y_total: Y_train and Y_test combined.
subject_total: subject_train and subject_test combined.
total: X_total, Y_total, subject_total combined.

