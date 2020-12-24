#include <sys/stat.h>
#include <sys/types.h>

 
#import "macros.h"
#import <Foundation/Foundation.h>
#import "downloader.h"
#import "hardware.h"

#import <UIKit/UIKit.h>
int welcome ()
{
if(geteuid() != 0)
{
printf(COLOUR_RED"SuccessionCLI needs to be run as root. Please \"su\" and try again. Alternatively, try \"ssh root@[IP Address\n"COLOUR_RESET);
return -1;
}
else
{
//the successionFolder is  "/private/var/mobile/Media/Succession/"
mkdir("/private/var/mobile/Media/Succession/", 0777);
downloader("curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist");
printf(COLOUR_GREEN"Welcome to SuccessionCLI! Written by Samg_is_a_Ninja and Hassan’s Tech (demhademha) \n Special thanks to pwn20wnd (mountpoint and rsync args) and shmoopi (for iOS System Services \n If you found this tool useful, then consider donating to demhademha at https://www.paypal.me/demhademha and to Samg_is_a_Ninja at \n https://www.paypal.me/SamGardner4 In addition, you can visit https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI to get support \n"COLOUR_RESET);
downloader("curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json");

NSString *systemVersion =systemversion();
NSString *deviceModel =devicemodel();
NSString *deviceType =devicetype();
NSString *deviceCommonName =devicecommonname();
printf(COLOUR_GREEN"Your %s (%s) (%s) is running iOS %s, press enter to continue or control + c if this is inaccurate \n %s", [deviceModel UTF8String], [deviceType UTF8String], [deviceCommonName UTF8String], [systemVersion UTF8String], COLOUR_RESET);

   
downloader("curl --silent  https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/SuccessionCLIVersion.txt");
FILE *fp;
   char str[60];

   /* opening file for reading */
   fp = fopen("/private/var/mobile/Media/Succession/SuccessionCLIVersion.txt", "r");
   if(fp == NULL) {
      perror("Error opening file");
exit(1);
   }
   if( fgets (str, 60, fp)!=NULL ) {




fclose (fp);
}
int result;
result = strcmp(str, current_succession_version);
 if (result ==0) 
{
}
else 
{ 
printf("The latest version of succession is %s and you are running %s, please upgrade through either your package manager or visiting successsion's github page \n", str, current_succession_version);
}
return 0;
}
}
