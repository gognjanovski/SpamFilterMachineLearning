#TEST DATA

N = dlmread('test-features.txt', ' ');
test_matrix = sparse(N(:, 1), N(:, 2), N(:, 3));

numTestDocs = size(test_matrix, 1);
numTestTokens = size(test_matrix, 2);

output = zeros(numTestDocs, 1);

% - Probability that one email is spam, number of spam emails divided by number of all emails
prob_spam = length(spam_indices)/numTrainDocs;


log_a = test_matrix*log(prob_token_spam') + log(prob_spam);
log_b = test_matrix*log(prob_token_nonspam') + log(1-prob_spam);

output = log_a > log_b;

test_labels = dlmread('test-labels.txt', ' ');

wrong_classification =  sum(xor(output, test_labels));

error = wrong_classification/numTestDocs
