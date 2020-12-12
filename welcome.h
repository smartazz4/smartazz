#import "macros.h"
#import <Foundation/Foundation.h>
#import "downloader.h"
#import "hardware.h"

#import <UIKit/UIKit.h>
void welcome ()
{
printf(COLOUR_GREEN"Welcome to SuccessionCLI, written by Samg_is_a_Ninja and Hassan’s Tech (demhademha) \n Special thanks to pwn20wnd (mountpoint and rsync args), The Procursus Team (for providing the procursus build system  used to build the command line tools) and shmoopi (for iOS System Services) \n If you found this tool useful, then consider donating to demhademha at https://www.paypal.me/demhademha and to Samg_is_a_Ninja at https://www.paypal.me/SamGardner4 In addition, you can visit https://github.com/Samgisaninja/SuccessionRestore/tree/SuccessionCLI to get support \n"COLOUR_RESET);
NSString *systemVersion =systemversion();
NSString *deviceModel =devicemodel();
NSString *deviceType =devicetype();
printf(COLOUR_GREEN"Your %s (%s) is running iOS %s, press enter to continue or control + c if this is inaccurate \n %s", [deviceModel UTF8String], [deviceType UTF8String], [systemVersion UTF8String], COLOUR_RESET);
downloader("0L", "https://raw.githubusercontent.com/Samgisaninja/samgisaninja.github.io/master/motd-cli.plist", "/private/var/mobile/Media/Succession/motd.plist");
}