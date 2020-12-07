#include <stdio.h>
//foundation
#import <Foundation/Foundation.h>
// UIKit
#import <UIKit/UIKit.h>

// Core Motion
#import <CoreMotion/CoreMotion.h>

// sysctl
#import <sys/sysctl.h>
// utsname
#import <sys/utsname.h>



int main () 
{
// Model of Device

    // Get the device model
        NSString *deviceModel = [[UIDevice currentDevice] model];
        NSString *deviceName = [[UIDevice currentDevice] name];
        

        NSString *systemName = [[UIDevice currentDevice] systemName];
        // Set the output to the system name
 
// System Version
        // Make a string for the system version
NSString *systemVersion = [[UIDevice currentDevice] systemVersion];        
NSString *deviceIdentifier = [[UIDevice currentDevice] localizedModel];
size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    
NSLog(@"Your device is named %@", systemName);
NSLog(@"Your device's model is %@", deviceModel);
NSLog(@"Your device is running iOS %@", systemVersion); 
NSLog(@"Your device is %@", deviceName);
NSLog(@"your device identifier is %@", deviceIdentifier);
NSLog(@"Your device machine I'd is %@", platform);
return 0;
}
