#import "log.h"

#import "folder_checker.h"
#include "file_checker.h"
#import <sys/stat.h>
#import  <sys/types.h>
#import "macros.h"
#import <Foundation/Foundation.h>
#import "downloader.h"
#import "hardware.h"
#import <UIKit/UIKit.h>
int result, folderExists, fileExists;


FILE *fp;
