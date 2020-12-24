#import <stdlib.h>
#include <stdio.h>
#include <dirent.h>
#include <errno.h>

int folder_checker(const char *folder)
{ 
DIR* dir = opendir(folder);
if (dir) {
    /* Directory exists. */
return 0;
    closedir(dir);
}
 else if (ENOENT == errno) {
return -1;
    /* Directory does not exist. */
} else {
return  -1;
    /* opendir() failed for some other reason. */

}
}