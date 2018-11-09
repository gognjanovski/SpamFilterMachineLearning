#TEST DATA

N = dlmread('test-features.txt', ' ');
test_matrix = sparse(N(:, 1), N(:, 2), N(:, 3));

numTestDocs = size(test_matrix, 1);
numTestTokens = size(test_matrix, 2);

output = zeros(numTestDocs, 1);

% - Probability that one email is spam, number of spam emails divided by number of all emails
% - Because the ration of spam - nonspam emails in the training set is 50:50 this probability will be 0.5 (50%)
prob_spam = length(spam_indices)/numTrainDocs;

% - Calculate the probability for spam and nonspam email for each of the emails in the test set
log_a = test_matrix*log(prob_token_spam') + log(prob_spam);
log_b = test_matrix*log(prob_token_nonspam') + log(1-prob_spam);

output = log_a > log_b;

% - Load the test emails labels 
test_labels = dlmread('test-labels.txt', ' ');

% - Calculate the wrong prediction of the model compared to the one of the test_labels
wrong_classification =  sum(xor(output, test_labels));

error = wrong_classification/numTestDocs
