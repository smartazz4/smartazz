#import "welcome.h"
int main ()
{
char *fileName="text.log";
logger("Began main function", fileName); 
logger("checking for  root", fileName);
if(geteuid() != 0)
{
logger("failed to obtain root, displaying failure alert...", fileName);
printf(COLOUR_RED"SuccessionCLI needs to be run as root. Please \"su\" and try again. Alternatively, try \"ssh root@[IP Address\n"COLOUR_RESET);
logger("successfully displayed failure alert", fileName);
logger("aborting succession_c", fileName);
exit(1);
}
else
{
logger("obtained root", fileName);
logger("checking if the succession folder exists", fileName);
if ((folderExists=folder_checker(SUCCESSION_FOLDER)) == -1)
{
//the successionFolder is  "/private/var/mobile/Media/Succession/"
logger("Creating the succession folder", fileName);
mkdir(SUCCESSION_FOLDER, 0777);
logger("created the succession folder", fileName);
logger("Downloading motd.plist", fileName);
downloader("curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist");
logger("Successfully download motd.plist", fileName);
logger("Downloading devices.json", fileName);
downloader("curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json");
logger("Successfully downloaded devices.json", fileName);
logger("Downloading SuccessionCLIVersion.txt", fileName);
downloader("curl --silent  https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/SuccessionCLIVersion.txt");
}
else if ((fileExists=file_checker(SUCCESSION_FOLDER"motd.plist")) ==-1)
{
logger("Motd.plist does not exist", fileName);
logger("Downloading motd.plist", fileName);
downloader("curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist");
}
else if ((fileExists=file_checker(SUCCESSION_FOLDER"devices.json")) ==-1)
  
{
downloader("curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json");
}
else if ((fileExists=file_checker(SUCCESSION_FOLDER"devices.SuccessionCLIVersion.txt")) ==-1) 
{
downloader("curl --silent  https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/SuccessionCLIVersion.txt");
}
else 
{
}

printf(COLOUR_GREEN"Welcome to SuccessionCLI! Written by Samg_is_a_Ninja and Hassan’s Tech (demhademha) \n Special thanks to pwn20wnd (mountpoint and rsync args) and shmoopi (for iOS System Services \n If you found this tool useful, then consider donating to demhademha at https://www.paypal.me/demhademha and to Samg_is_a_Ninja at \n https://www.paypal.me/SamGardner4 In addition, you can visit https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI to get support \n"COLOUR_RESET);

NSString *systemVersion =systemversion();
NSString *deviceModel =devicemodel();
NSString *deviceType =devicetype();
NSString *deviceCommonName =devicecommonname();
printf(COLOUR_GREEN"Your %s (%s) (%s) is running iOS %s, press enter to continue or control + c if this is inaccurate \n %s", [deviceModel UTF8String], [deviceType UTF8String], [deviceCommonName UTF8String], [systemVersion UTF8String], COLOUR_RESET);

   
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
result = strcmp(str, CURRENT_SUCCESSION_VERSION);
 if (result ==0) 
{
}
else 
{ 
printf("The latest version of succession is %s and you are running %s, please upgrade through either your package manager or visiting successsion's github page \n", str, CURRENT_SUCCESSION_VERSION);
}
int a;
a=file_checker("file.txt");
printf("%i", a);
return 0;
}
}
