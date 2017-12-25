//Tyler Griffith
//11-26-17
//~/csc3410/p7/p7.c
//This program will read a file of 100 possible integers then call 
//an assembly program to sort them
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int *mergesort(int *arr, int size);         //DECLARING THE MERGESORT FUNCTION
int main(void){
   /*CODE TO READ THE FILE AND STORE ALL THE NUMBERS IN AN ARRAY*/
   FILE* fp = fopen("data", "r");
   char buffer[5];
   int array[100];
   int i = 0;
   while(fgets(buffer, 5, (FILE*) fp)) {
      array[i] = atoi(buffer);
      i++;
   }
   mergesort(array, 100);
   fclose(fp);   
   /*Code to print the array of random numbers. JUST TO CHECK. COMMENT THIS PART LATER*/
   for(i=0; i<100; i++){
      printf("%d\n", array[i]);
   }
   /*Code to print the array of random numbers.*/
   /*********CALL ASSEMBLY FUNCTION HERE*****/
   return 0;
}