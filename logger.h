#import <stdio.h>
#import <stdlib.h>

void logger (char *log_message, const char *fileName)
{

    FILE *file;
    FILE *p;
//char c;
//char result;
//chardate_and_time;
file = fopen(fileName, "w+");
    char number[100];
p=popen("date '+%F %X'", "r");
    while (fgets(number, 100, p) != NULL) {
fprintf(file,"%s: %s \n", number, log_message);
    }
    pclose(p);
fclose(file);
}