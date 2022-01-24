%% Wordle solver by Philip Hoddinott
% Makes it easier to solve wordles

%% Set up
% clear enviorment, load word list
close all; clear all;
load('wordListCur.mat');
curList =[]; % current list of words it could be is empty

%% Input your guesses
% User run section
% put in letters knocked out, included, and known postions

% blackedOutLetters
knockOutLetters = [''];
% letters in yellow / green               
includeLetters = [''];
% letters you know to be in a postion (green letters)
%                  1   2   3   4   5
postionLetters = [' ',' ',' ',' ',' '];
% Letters you know are not in a postion (yellow letters)
%                        1  2  3  4  5
knowNotPostionLetter = ["";"";"";"";""];

for i = 1:length(wordlist)
    % set up loop
    curWord = char(wordlist(i));
    
    %% deal with exculuded letters
    curWord_X_knockOut = intersect(curWord,knockOutLetters); % if there are no knocked out letters it should be empty
    if ~isempty(curWord_X_knockOut) % if empty then this guess is wrong and move on
        continue;
    end
    
    %% deal with postion letters
    % note no fancy intersects here, not sure how to easily mark postion
    if postionLet(curWord,postionLetters) == 1
        continue; % go to next loop run
    end  
    
    %% deal with know not postion letter
    % note uses function
    if knowNotPos(curWord,knowNotPostionLetter) == 1
        continue;
    end  
    
    %% deal with included letters
    curWord_X_include = intersect(curWord,includeLetters);
    if length(curWord_X_include) == length(includeLetters) % the length is the same
        curList = [curList; wordlist(i)]; % add to list
    end
    
end

fprintf('Choices could be:\n');
disp(curList);
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

function outVal = postionLet(curWord,postionLetters)
    % deal with letters known to be in that postion
    for j = 1:length(postionLetters)
        if postionLetters(j)~=' ' % ignore unknown positons
            if curWord(j)~=postionLetters(j) % if the letter in that postion does not match
                outVal = 1;
            end
        end
    end
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
                outVal = 1;
            end
        end
    end
    
end
            
            
        