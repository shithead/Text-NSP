###############################################################################

#			UNIT TEST A15c FOR kocos.pl

###############################################################################

#       Test A15c  -    Checks if the program finds correct 3rd order 
#			co-occurrences when each token is a bigram 
#	Input	-	test-A15.count
#	Output	-	test-A15c.reqd

echo "UNIT Test A15c -";
echo "		For kth order co-occurrence program kocos.pl";
echo "Input - 	Source file from test-A15.count";
echo "Output - 	Destination file from test-A15c.reqd";
echo "Test -    	Checks if the program finds correct 3rd order";
echo "		co-occurrences when each token is a bigram";


#=============================================================================
#				INPUT
#=============================================================================

set TestInput="test-A15.count";
set Actual="test-A15c.reqd";

#=============================================================================
#				RUN THE PROGRAM
#=============================================================================

 kocos.pl --literal "alan bond" --order 3 $TestInput > test-A15c1.output
 kocos.pl --regex test-A15.regex --order 3 $TestInput > test-A15c2.output


#=============================================================================
#				SORT THE RESULTS AND COMPARE
#=============================================================================
sort test-A15c1.output > t1
sort $Actual > t2
diff -w t1 t2 > variance1

sort test-A15c2.output > t1
diff -w t1 t2 > variance2
#=============================================================================
#				RESULTS OF TESTA15c
#=============================================================================
if(-z variance1 && -z variance2) then
        echo "STATUS : 	OK Test Results Match.....";
else
	echo "STATUS : 	ERROR Test Results don't Match....";
        echo "		When Tested for --literal "alan bond"";
        cat variance1
	echo "          When Tested for --regex test-A15.regex ";
        cat variance2
endif
echo ""
/bin/rm -f t1 t2 variance1 variance2

#############################################################################

