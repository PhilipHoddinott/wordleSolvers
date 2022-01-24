%% Wordle Auto solver by Philip Hoddinott
% Automatic wordle solving

%% Set up
% clear enviorment, load word list
close all; clear all;
load('wordListCur.mat');


%% Input your guesses
% put in letters knocked out, included, and known postions

knockOutLetters = [''];
               
includeLetters =[''];
%                 1   2   3   4   5
postionLetters =[' ',' ',' ',' ',' '];

% possible improvment, a square that is known to not be a letter / yellow
% squares
knowNotPostionLetter = ["";"";"";"";""];
realWord = 'panic';
firstGuess = 'adieu';
% firstGuess = 'steam';
guessWord = firstGuess;
for i = 1:6
    if isGuessRight(guessWord,realWord)
        break;
    end
    [knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter] = compareGuessToReal(guessWord,realWord,knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter);
    curList = makeWordList(wordlist,knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter);
    printWordleGuessOutput(i,curList,knockOutLetters,includeLetters);
    
    guessWord = char(curList(1));
    fprintf('guess is first of cur list: %s\n',guessWord);
    
end

fprintf('after %d guesses, got right word (%s)\n',i,guessWord);

function [endGameVal] = isGuessRight(guessWord,realWord)
    if strcmp(guessWord,realWord)
        endGameVal = 1;
    else
        endGameVal = 0;
    end
end

function [knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter] = compareGuessToReal(guessWord,realWord,knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter)

if ~isempty(char(intersect(realWord,guessWord)))
    includeLetters = [includeLetters,' ',char(intersect(realWord,guessWord))];
end

if ~isempty(char(setdiff(guessWord,realWord)))
    knockOutLetters = [knockOutLetters,' ',char(setdiff(guessWord,realWord))];
end
% knockOutLetters = [knockOutLetters, ' ',char(setdiff(guessWord,realWord))];

for i = 1:5
    if strcmp(guessWord(i), realWord(i))
        postionLetters(i) = realWord(i);
    else
        postionLetters(i) = ' ';
    end
    
    tempChr = char(knowNotPostionLetter(i));
    if isempty(tempChr)
        curK='';
    else
        curK = tempChr;
    end
    if postionLetters(i)==' '
        for j = 1:length(includeLetters)
            curK = [curK,includeLetters(j)];
        end
        knowNotPostionLetter(i) = string(curK);
    end
    
end


knowNotPostionLetter = ["";"";"";"";""];
        includeLetters = strtrim(includeLetters);
    includeLetters = unique(includeLetters);
    knockOutLetters = strtrim(knockOutLetters);
    knockOutLetters = unique(knockOutLetters);

end % end function

function worleOutput = makeWordlOutput(wordlist,knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter,realWord)

knockOutLetters = ['diu m'];
               
includeLetters =['ae'];
%                 1   2   3   4   5
postionLetters =['a',' ','b','e',' '];

% possible improvment, a square that is known to not be a letter / yellow
% squares
knowNotPostionLetter = ["";"";"";"";""];
realWord = 'knoll';



end

function wordListOut = makeWordList(wordlist,knockOutLetters,includeLetters,postionLetters,knowNotPostionLetter)
    curList =[]; % current list of words it could be is empty
    includeLetters = strtrim(includeLetters);
    includeLetters = unique(includeLetters);
    knockOutLetters = strtrim(knockOutLetters);
    knockOutLetters = unique(knockOutLetters);
    for i = 1:length(wordlist)
        % set up loop
        curWord = char(wordlist(i));
        breakLoop = 0; % reset loop break

        if strcmp(curWord,'knoll')
            a = 1;
        end
        %% deal with exculuded letters
        curWord_X_knockOut = intersect(curWord,knockOutLetters); % if there are no knocked out letters it should be empty
        if ~isempty(curWord_X_knockOut) % if empty then this guess is wrong and move on
            continue;
        end

        %% deal with postion letters
        % note no fancy intersects here, not sure how to easily mark postion
        curWord_X_postion = intersect(curWord,postionLetters);
        for j = 1:length(postionLetters)
            if postionLetters(j)~=' ' % ignore unknown positons
                if curWord(j)~=postionLetters(j) % if the letter in that postion does not match
                    breakLoop = 1;
                end
            end
        end
        if breakLoop == 1
            breakLoop = 0;
            continue;
        end  

        %% deal with know not postion letter
        % note uses function
        breakLoop = knowNotPos(curWord,knowNotPostionLetter);
        if breakLoop == 1
            breakLoop = 0;
            continue;
        end  
        %% deal with included letters
        curWord_X_include = intersect(curWord,includeLetters);
        
        if length(curWord_X_include) == length(includeLetters) % the length is the same
            curList = [curList; wordlist(i)]; % add to list
        elseif includeLetters== ' '
            curList = [curList; wordlist(i)]; % add to list
        end

    end
    wordListOut = curList;
end



function outVal = knowNotPos(curWord,knowNotPostionLetter)
    % deal with letters known to not be in that postion
    % knowNotPostionLetter = ['';'';'';'';''];
    outVal = 0;
    for i = 1:5
        curLet = char(knowNotPostionLetter(i));
        if ~isempty(curLet) % check if empty
            notPosInter = intersect(curWord(i),curLet); % will be a letter if one should not be there
            if ~isempty(notPosInter)
                outVal = outVal +1;
            end
        end
    end
    
    if outVal~=0
        outVal = 1;
    end
end

function [] = printWordleGuessOutput(runNum,curList,knockOutLetters,includeLetters)
    fprintf('\n\nrun number %d\n',runNum);
    % fprintf('Choices could be:\n');
    % disp(curList');
    fprintf('removed letters are:\t');
    for i = 1:length(knockOutLetters)
        fprintf(' %s, ',knockOutLetters(i));
    end
    fprintf(' %d removed\n',length(knockOutLetters));

    fprintf('known letters are: \t');
    for i = 1:length(includeLetters)
        fprintf(' %s, ',includeLetters(i));
    end
    fprintf(' %d/5 known\n',length(includeLetters));
    fprintf('%d possible choices\n',length(curList));
end

            
            
        