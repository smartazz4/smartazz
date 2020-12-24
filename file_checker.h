#import <stdio.h>
#import <stdlib.h>
int file_checker(const char *fileName)
{
    FILE *file;
    if ((file = fopen(fileName, "r")))
    {
        fclose(file);
        return 0;
    }
else 
{
return -1;
}
}