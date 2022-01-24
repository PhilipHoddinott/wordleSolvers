# wordleSolvers
MATLAB Wordle Tools

Pretty simple MATLAB tool to help you solve wordle: https://www.powerlanguage.co.uk/wordle/

For HoddinottWordleSolver.m

To use make a guess on wordle. ADIEU is a good one. Then edit the foillowing variables:  

1. knockOutLetters, with the black letters
2. includeLetters with yellow and green letters
3. postionLetters with the green letters you know to be in that postion 
4. knowNotPostionLetter with all yellow letters you know to be used but not in that postion. 

So if you put in ADIEU and the answer is AGEIS, with A in green, E+I in yellow, and D+U in grey you will have:

knockOutLetters = ['du'];

includeLetters = ['aie'];

postionLetters = ['a',' ',' ',' ',' '];

knowNotPostionLetter = ["";"";"i";"e";""];

And a handy list of guesses wll be outputted. 

For HoddinottWordleSolverAuto.m

This uses the same logic but automaticaly guesses the wordle. Can only be used once wordle has been solved. 
If you want practice wordles use webarchive: http://web.archive.org/web/*/https://www.powerlanguage.co.uk/wordle/
