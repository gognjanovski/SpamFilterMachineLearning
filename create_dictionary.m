allwords = "";

% - Load and concatenate all the emails in one string
Files=dir('data/*/*.txt');
for k=1:length(Files)
    FileNames = Files(k).name;
    dr = Files(k).folder;
    file = fileread(strcat(dr, '\', FileNames));
    file = regexprep(file, '\<\w{1,2}\>', "");
    allwords = strcat(allwords, ' ', file);
end

% - Split the emails by white space so we can count the number of occurence of each of the words
words = strsplit(allwords, ' ' )';
[words_u, ~, idxU] = unique(words);
counts = accumarray( idxU, 1 );
% - Sort entries by count.
[~, idxS] = sort( counts, 'descend' );
words_us = words_u(idxS)(1:2500);
counts_s = counts(idxS)(1:2500);

% - Build cell array of unique words and counts.
result = [words_us, num2cell( counts_s )];
result = result(1:2500, :);

% - Save the word count in dictionary.txt file
filePh = fopen('dictionary.txt','w');
[rows,cols]=size(result);
for r=1:rows
    fprintf(filePh,'%d. %s %d\n', r, result(r,1){:}, result(r,2){1});
end
fclose(filePh);