#include <dirent.h>
#include <errno.h>
int folder_checker(char folder)
{ 
DIR* dir = opendir(folder);
if (dir) {
    /* Directory exists. */
return 0;
    closedir(dir);
} else if (ENOENT == errno) {
return -1;
    /* Directory does not exist. */
} else {
retrun -1;
    /* opendir() failed for some other reason. */

share  