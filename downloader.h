#include <stdio.h>
int downloader(char *command)
{
    FILE *cmd;
    char result;
cmd = popen(command,"r+");
    if( cmd == NULL)
    {
        puts("Unable to open process");
        return(1);
    }
while( (result=fgetc(cmd)) != EOF)
        putchar(result);
    pclose(cmd);

    return(0);
}
