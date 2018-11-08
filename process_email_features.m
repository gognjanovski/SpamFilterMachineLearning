dictionaryList = get_dictionary_list();


#Train Features
#Train Labels

docId = 1;
featureTrain = zeros(1,3);
labelTrain = zeros(1,1);

Files=dir("data/nonspam-train/*.txt");
for k=1:length(Files)
    FileNames = Files(k).name;
    dr = Files(k).folder;
    file = fileread(strcat(dr, '\', FileNames));
    file = regexprep(file, "\<\w{1,2}\>", "");

    for i=1:length(dictionaryList)
        word = dictionaryList(i);
        [C w_count]= strsplit(file, word);
        w_count = length(w_count);
        if w_count > 0
            featureTrain = [ featureTrain; [docId i w_count]];
        end
    end

    labelTrain = [labelTrain; 0];
    docId = docId + 1;

    if docId > 50
        break;
    end
end

Files=dir("data/spam-train/*.txt");
for k=1:length(Files)
    FileNames = Files(k).name;
    dr = Files(k).folder;
    file = fileread(strcat(dr, '\', FileNames));
    file = regexprep(file, "\<\w{1,2}\>", "");

    for i=1:length(dictionaryList)
        word = dictionaryList(i);
        [C w_count]= strsplit(file, word);
        w_count = length(w_count);
        if w_count > 0
            featureTrain = [ featureTrain; [docId i w_count]];
        end
    end

    labelTrain = [labelTrain; 1];
    docId = docId + 1;

    if docId > 100
        break;
    end
end

featureTrain = featureTrain(2:end,:);
labelTrain = labelTrain(2:end,:);

dlmwrite('train-features.txt', featureTrain, 'delimiter',' ');
dlmwrite('train-labels.txt', labelTrain);


#Test Features
#Test Labels

docId = 1;
featureTest = zeros(1,3);
labelTest = zeros(1,1);

Files=dir("data/nonspam-test/*.txt");
for k=1:length(Files)
    FileNames = Files(k).name;
    dr = Files(k).folder;
    file = fileread(strcat(dr, '\', FileNames));
    file = regexprep(file, "\<\w{1,2}\>", "");

    for i=1:length(dictionaryList)
        word = dictionaryList(i);
        [C w_count]= strsplit(file, word);
        w_count = length(w_count);
        if w_count > 0
            featureTest = [ featureTest; [docId i w_count]];
        end
    end

    labelTest = [labelTest; 0];
    docId = docId + 1;



end

Files=dir("data/spam-test/*.txt");
for k=1:length(Files)
    FileNames = Files(k).name;
    dr = Files(k).folder;
    file = fileread(strcat(dr, '\', FileNames));
    file = regexprep(file, "\<\w{1,2}\>", "");

    for i=1:length(dictionaryList)
        word = dictionaryList(i);
        [C w_count]= strsplit(file, word);
        w_count = length(w_count);
        if w_count > 0
            featureTest = [ featureTest; [docId i w_count]];
        end
    end

    labelTest = [labelTest; 1];
    docId = docId + 1;

   

end

featureTest = featureTest(2:end,:);
labelTest = labelTest(2:end,:);

dlmwrite('test-features.txt', featureTest, 'delimiter',' ');
dlmwrite('test-labels.txt', labelTest);