#import "welcome.h"
int main ()
{
    log_set_quiet(0);

    fp = fopen("./log.txt", "wb");
log_add_fp(fp, 0);



log_trace("Began main function");

log_trace("checking for  root");
if(geteuid() != 0)
{
log_trace("Failed to obtain root, displaying failure alert...");
printf(COLOUR_RED"SuccessionCLI needs to be run as root.Please \"su\" and try again. Alternatively, try \"ssh root@IP Address \n"COLOUR_RESET);
log_trace("successfully displayed failure alert");
log_trace("aborting succession_c");
return -1;
}
else
{
log_trace("obtained root");
log_trace("checking if the succession folder exists");
if ((folderExists=folder_checker(SUCCESSION_FOLDER)) == -1)
{
//the successionFolder is  "/private/var/mobile/Media/Succession/"
log_trace("Creating the succession folder");
mkdir(SUCCESSION_FOLDER, 0777);
log_trace("created the succession folder");
log_trace("Downloading motd.plist");
downloader("curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist");
log_trace("Successfully downloaded motd.plist");
log_trace("Downloading devices.json");
downloader("curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json");
log_trace("Successfully downloaded devices.json");
log_trace("Downloading SuccessionCLIVersion.txt");
downloader("curl --silent  https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/SuccessionCLIVersion.txt");
log_trace("Downloaded SuccessionCLIVersion.txt");
}
else {
log_trace("The succession folder already exists");
}
if ((fileExists=file_checker(SUCCESSION_FOLDER"motd.plist")) ==-1)
{
log_trace("Motd.plist does not exist");
log_trace("Downloading motd.plist");
downloader("curl --silent https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist -o /private/var/mobile/Media/Succession/motd.plist");
log_trace("Downloaded motd.plist");
}
else {
log_trace("motd.plist exists");
}
if ((fileExists=file_checker(SUCCESSION_FOLDER"devices.json")) ==-1)
  
{
log_trace("Devices.json does not exist");
log_trace("Downloading devices.json");
downloader("curl --silent 'https://api.ipsw.me/v4/devices' -o /private/var/mobile/Media/Succession/devices.json");
log_trace("Downloaded devices.json");
}
else {
log_trace("Devices.json already exists");
}
if ((fileExists=file_checker(SUCCESSION_FOLDER"SuccessionCLIVersion.txt")) ==-1) 
{
log_trace("SuccessionCLIVersion.txt does not exist");
log_trace("Downloading SuccessionCLIVersion.txt");
downloader("curl --silent  https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/SuccessionCLIVersion.txt -o /private/var/mobile/Media/Succession/SuccessionCLIVersion.txt");
log_trace("Downloaded SuccessionCLIVersion.txt");
}
else 
{
log_trace("successionCLIVersion.txt already exists"); 
}
log_trace("Setting the system version");
NSString *systemVersion =systemversion();
log_trace("The system version is %s", [systemVersion UTF8String]);
log_trace("Setting the device model");
NSString *deviceModel =devicemodel();
log_trace("The device model  is %s", [deviceModel UTF8String]);
log_trace("Setting the device type");
NSString *deviceType =devicetype();
log_trace("The device type is   %s", [deviceType UTF8String]);
log_trace("setting the  device common name"); 
NSString *deviceCommonName =devicecommonname();
log_trace("The device common name  is   %s", [deviceCommonName UTF8String]);
log_trace("Checking if the device is an iPhone 6s on iOS 9");   
    if ([deviceType isEqualToString: @"iPhone8,1"] || [deviceType isEqualToString: @"iPhone8,2"]) 
{
log_trace("Device is not supported, displaying failure alert");
printf(COLOUR_RED"Succession is disabled: the iPhone 6s cannot be activated on iOS 9."COLOUR_RESET);
log_trace("Aborting succession");
exit(-1);
}
printf(COLOUR_GREEN"Welcome to SuccessionCLI! Written by Samg_is_a_Ninja and Hassan’s Tech (demhademha) \n Special thanks to pwn20wnd (mountpoint and rsync args) and shmoopi (for iOS System Services \n If you found this tool useful, then consider donating to demhademha at https://www.paypal.me/demhademha and to Samg_is_a_Ninja at \n https://www.paypal.me/SamGardner4 In addition, you can visit https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI to get support \n"COLOUR_RESET);

/*NSString *systemVersion =systemversion();
NSString *deviceModel =devicemodel();
NSString *deviceType =devicetype();
NSString *deviceCommonName =devicecommonname();
*/
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
    fclose(fp);
return 0;
}
}
