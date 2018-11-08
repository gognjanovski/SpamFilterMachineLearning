function dictionaryList = getDictionaryList()
%GETDICTIONARYLIST reads the fixed vocabulary list in vocab.txt and returns a
%cell array of the words
%   dictionaryList = GETDICTIONARYLIST() reads the fixed vocabulary list in dictionary.txt 
%   and returns a cell array of the words in dictionaryList.


%% Read the fixed vocabulary list
fid = fopen('dictionary.txt');

% Store all dictionary words in cell array vocab{}
n = 2500;  % Total number of words in the dictionary

% For ease of implementation, we use a struct to map the strings => integers
% In practice, you'll want to use some form of hashmap
dictionaryList = cell(n, 1);
for i = 1:n
    % Word Index (can ignore since it will be = i)
    fscanf(fid, '%s', 1);
    % Actual Word
    dictionaryList{i} = fscanf(fid, '%s', 1);
    fscanf(fid, '%d', 1);
end
fclose(fid);

end
