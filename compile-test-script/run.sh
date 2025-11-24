#!/bin/bash

FOLDER=$1;
CODE=$2;
BONUS=$3;
TEST="TEST/";
OK=0;
FAIL=0;
TOTAL=0;

if [ "$BONUS" == "-b" ]; then
  TEST="TEST/BONUS/";
fi

g++ -Wall -pedantic "$FOLDER"/"$CODE" -o sol;

OUT_C=$(ls "$FOLDER"/"$TEST"/ | grep -v "win" | grep 'out' | wc -l);
IN_C=$(ls "$FOLDER"/"$TEST"/ | grep -v "win" | grep 'in' | wc -l);

if [ $OUT_C -eq $IN_C ]; then
  for i in $(seq 0 $(($IN_C-1))); do
    TEST_IN=$(ls "$FOLDER"/"$TEST"/ | grep -v "win" | grep "000${i}_in.txt");
    TEST_OUT=$(ls "$FOLDER"/"$TEST"/ | grep -v "win" | grep "000${i}_out.txt");
    ./sol < "$FOLDER"/"$TEST"/"$TEST_IN" > my_out.txt;
    TOTAL=$(($TOTAL+1));
    if diff my_out.txt "$FOLDER"/"$TEST"/"$TEST_OUT" >/dev/null; then
      echo "OK: TEST ${i}";
      OK=$(($OK+1));
    else
      FAIL=$(($FAIL+1));
      echo "FAIL: TEST ${i}";
      echo "-------------------------"
      echo "INPUT:"; cat "$FOLDER"/"$TEST"/"$TEST_IN";
      echo "-------------------------"
      echo "MY OUTPUT:"; cat "my_out.txt";
      echo "-------------------------"
      echo "REF. OUTPUT:"; cat "$FOLDER"/"$TEST"/"$TEST_OUT";
    fi
    echo "-------------------------"; echo;
  done
  echo "FAILED $FAIL/$TOTAL, PASSED $OK/$TOTAL";
else 
  echo "Wrong $TEST folder setup"
fi
echo "-------------------------"; echo; echo;
echo "Running memory test with valgrind for test 0000_in.txt."; echo "-------------------------";
valgrind --leak-check=full ./sol < "$FOLDER"/"$TEST"/"0000_in.txt";

rm -f sol my_out.txt;
