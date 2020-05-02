All the work that we need to do can be split in 5 steps:

--> Prepare the Data

--> Generate Dictionary

--> Generate Features

--> Generate ML Model

--> Test the ML Model


  Prepare the Data:

All the email data is contained in the data folder. This email dataset contains 4 folders. The are separated in two subsets — spam and non-spam emails.
nonspam-train — train dataset, contains 350 nonspam emails
spam-train — train dataset, contains 350 spam emails
nonspam-test — test dataset, contains 130 nonspam emails
spam-test — test dataset, contains 130 spam emails

Now if we open one of the emails we can see that they has already been pre-processed (cleaned from interpunction and special characters). Since this step can be done in many different ways, these are some of the possible filters that can be applied.
Lower-casing: The entire email is converted into lower case, so that captialization is ignored (e.g., IndIcaTE is treated the same as Indicate).
Stripping HTML: All HTML tags are removed from the emails. Many emails often come with HTML formatting; we remove all the HTML tags, so that only the content remains.
Normalizing URLs: All URLs are replaced with the text “httpaddr”.
Normalizing Email Addresses: All email addresses are replaced with the text “emailaddr”.
Normalizing Numbers: All numbers are replaced with the text “number”.
Normalizing Dollars: All dollar signs ($) are replaced with the text “dollar”.
Word Stemming: Words are reduced to their stemmed form. For example, “discount”, “discounts”, “discounted” and “discounting” are all replaced with “discount”. Sometimes, the Stemmer actually strips off additional characters from the end, so “include”, “includes”, “included”, and “including” are all replaced with “includ”.
Removal of non-words: Non-words and punctuation have been removed.
All white spaces (tabs, newlines, spaces) have all been trimmed to a single space character.


Generate Dictionary (Vocabulary):

After we got the data prepared we can start creating the dictionary where we are gonna choose the features (words in this case) based on which the algorithm will later decide if given email message is spam or nonspam.
First thing we need to do is to create the dictionary of words that will be used for our model. There are a lot of possible ways to generate (choose) the words, in this example we will choose the first 2500 most frequent words counting all the emails (from all of the folders).
The code for generating the dictionary is in create_dictionary.m file. This code will take all the files (emails) under data folder and count the number of occurrences of each word. Then select the 2500 most frequent words and write them down in file called dictionary.txt

After the dictionary is created is should look like this.
1. email 2163
2. order 1648
3. address 1645
4. language 1534
5. report 1384
6. mail 1364
Now we have created our dictionary that and we are ready to go to the next step.


Generating Features:

In this step we are going to extract the features from the train and test emails so the result structure is prepared as a input to the Naive Bayes algorithm in the next step of generating the prediction model.
The dictionary that we already created contains all the 2500 words (features) based on which we will create the prediction model. What we need to do is to count number of occurrences of each word from the dictionary in the emails. The data structure will be like like the following.

1 7 1

1 12 2

1 19 2

1 22 1

1 25 1

Here the each row corresponds to:

--> first column — document sequence number

--> second column — sequence number for the word in the dictionary

--> third column — number of occurrences of the word from dictionary in the given email
For the first row it means that document number is 1 which is the 3–380msg4.txt from the nonspam-train folder under data folder.

In the end we should get 4 .txt files.

--> train-features.txt — which will contain the data structured as above for the emails from nonspam-train and spam-train folders

--> train-labels.txt — which will contain one column and the number of rows will be equal to the number of processed emails. This data will be 0 if email is from nonspam-train folder and 1 if the data is from spam-train folder

--> test-features.txt — which will contain the data structured as above for the emails from nonspam-test and spam-test folders

--> test-labels.txt — which will contain one column and the number of rows will be equal to the number of processed emails. This data will be 0 if email is from nonspam-test folder and 1 if the data is from spam-test folder
Now we gonna look at the process_email_features.m file. Here we can split the code in 4 small parts. In the processing we include 50 emails from spam-train and nonspam-train and 130 (all) from spam-test and nonspam-test.

First, we read the nonspam-train folder where for each email we count each word from the dictionary and if particular word occurs then we write it down as a row in featureTrain matrix (docId, wordId, count). Also for each email we put a row in labelTrain matrix (in this case all 0 since it’s nonspam folder). We repeat same step for spam-train folder except here labelTrain matrix will add 1 for each email (since it’s spam folder). So we get test-features.txt and test-labels.txt
We repeat the same steps for the nonspam-test and spam-test folders and at the end we get train-features.txt and train-labels.txt.

Now we have prepared the emails and they are ready for training the ML Model in the next step.


Generate Machine Learning Model:

We have our data structured and prepared for running it through Naive Bayes algorithm so we can get the prediction model. The Naive Bayes is also called “probabilistic classifier” since it is based on calculating the probability that one item (email in our case) belongs to a particular class (classification).
It’s formula is pretty simple. It counts the number of occurrences of a w (in our case one word from the dictionary) in all the c (sum of all occurrences of the dictionary words in ether spam or nonspam emails depending for which one we are estimating the probability). V — is the number of words in the dictionary. This probability will be calculated separately first on spam and then on nonspam emails.

First we read our features from the train-features.txt file. Load them in sparse matrix (matrix which stores only non-zero elements to save space). Then we create full matrix which will be 100 x 2500 were each row will represent one email end each column number of occurrence of dictionary word in that email. The variables are self describing so please comment if you have anything else to ask.
prob_token_spam — calculates the probability of occurrence of each word in the spam emails
prob_token_nonspam — calculates the probability of occurrence of each word in the nonspam emails
Now that we have calculated all the parameters of our model we can go to the final step.


Test the ML Model:

In this final step we are going to test our model on the test data set that we already have. Previously we prepared the test set in the Generate Features section.

Here we load our test-features.txt files and create a full matrix which in this case is 130 x 2500 since we took all the test emails. We calculate the prob_spam which is the probability that given email will be a spam email counting all the trained emails (spam + nonspam).
Then we multiply each of the word occurrences for each email in the test_matrix with our generated model, prob_token_spam and prob_token_nonspam for spam and nonspam emails respectively.
Basically our model represent the weight (impact) that each word has when deciding if given email is spam or nonspam
The output variable contains true/false parameters for each email. To calculate the error rate of our model we compare (xor) the output (predictions from our model) with the real label for the test emails and sum the wrong classifications. In the end we just divide it with the number of test email and should get value of 0.023077 which is telling us that our model is predicting with accuracy of 97.6923%.
