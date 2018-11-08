numTrainDocs = 100;
numTokens = 2500;

% - Load train emails features
M = dlmread('train-features.txt', ' ');
spmatrix = sparse(M(:, 1), M(:, 2), M(:, 3), numTrainDocs, numTokens);
train_matrix = full(spmatrix);

% - Load train emails labels
train_labels = dlmread('train-labels.txt', ' ');

% - Find spam emails indexes and nonspam emails indexes
spam_indices = find(train_labels);
nonspam_indices = find(train_labels == 0);

% - Number of words for each email
email_lengths = sum(train_matrix, 2);

% - Count number of words in spam emails and number of words in nonspam emails
spam_wc = sum(email_lengths(spam_indices));
nonspam_wc = sum(email_lengths(nonspam_indices));

% - Impact of each word of the dictionary in the spam and nonspam classification
prob_token_spam = ( sum(train_matrix(spam_indices, :)) + 1) ./ (spam_wc + numTokens);
prob_token_nonspam = ( sum(train_matrix(nonspam_indices, :)) + 1) ./ (nonspam_wc + numTokens);