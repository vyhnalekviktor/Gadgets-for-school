# Compile - Run - Test script for Progtest
Bash script I have on my school Gitlab in Progtest repo. It is used for running automated tests for my exercises.

## How to use
1. setup your folder structure:
	- `/FOLDER/main.c` -> program I want to test
	- `/FOLDER/bonus.c` -> voluntary bonus program
	- `/FOLDER/TEST/` -> folder for tests
		- `000x_in.txt` & `000x_out.txt`	->	test input and output
	- `/FOLDER/TEST/BONUS/` -> voluntary folder for bonus tests
		- contains tests in same format as normal
2. run the test script
	- `$ ./run.sh "$FOLDER" "$CODE" "$PARAM"` 
	- with each parameter meaning:
		- `$FOLDER` -> contains code + TEST/*
		- `$CODE` -> code we want to test
		- `$PARAM` -> voluntary -b, calls the bonus tests
3. results
	- prints out the results - OK/FAIL
	- if FAIL, prints out INPUT, MY OUTPUT, REF. OUTPUT
	- prints out total score
	- runs the first test with valgrind for memory check
