#include <time.h>
#import <stdio.h>
#import <stdlib.h>

void logger (char *log_message, const char *fileName)
{

    FILE *file;
file = fopen(fileName, "w+");

  time_t t = time(NULL);
  struct tm tm = *localtime(&t);

fprintf(file,"%d-%02d-%02d %02d:%02d:%02d: %s", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec, log_message);
fclose(file);
}