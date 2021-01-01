#import "hardware.h"
// Model of Device
NSString *devicemodel() {
    // Get the device model
    if ([[UIDevice currentDevice] respondsToSelector:@selector(model)]) {
        // Make a string for the device model
        NSString *deviceModel = [[UIDevice currentDevice] model];
        // Set the output to the device model
        return deviceModel;
    } else {
        // Device model not found
        return nil;
    }
}

// Device Name
 NSString *devicename() {
    // Get the current device name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(name)]) {
        // Make a string for the device name
        NSString *deviceName = [[UIDevice currentDevice] name];
        // Set the output to the device name
        return deviceName;
    } else {
        // Device name not found
        return nil;
    }
}

// System Name
 NSString *systemName() {
    // Get the current system name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemName)]) {
        // Make a string for the system name
        NSString *systemName = [[UIDevice currentDevice] systemName];
        // Set the output to the system name
        return systemName;
    } else {
        // System name not found
        return nil;
    }
}

// System Version
NSString *systemversion() {
    // Get the current system version
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemVersion)]) {
        // Make a string for the system version
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        // Set the output to the system version
        return systemVersion;
    } else {
        // System version not found
        return nil;
    }
}
// System Device Type (iPhone1,0) 
NSString *devicetype() {

 // Set up a Device Type String

        // Unformatted
            NSString *deviceType;
            // Set up a struct
            struct utsname dt;
            // Get the system information
            uname(&dt);
            // Set the device type to the machine type
            deviceType = [NSString stringWithFormat:@"%s", dt.machine];

            // Return the device type
            return deviceType;
}
NSString *devicecommonname()
{
		size_t size;
		sysctlbyname("hw.machine", NULL, &size, NULL, 0);
		char *modelChar = malloc(size);
		sysctlbyname("hw.machine", modelChar, &size, NULL, 0);
		NSString *deviceModelString = [NSString stringWithUTF8String:modelChar];
		free(modelChar);
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/mobile/Media/Succession/devices.json"]) {
			NSArray *devicesArray = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:@"/private/var/mobile/Media/Succession/devices.json"] options:kNilOptions error:nil];
			for (NSDictionary *deviceInfo in devicesArray) {
				if ([[deviceInfo objectForKey:@"identifier"] isEqualToString:deviceModelString]) {
NSString *deviceCommonName=[deviceInfo objectForKey:@"name"];
return deviceCommonName;
				}
			}
		} else {
			printf("Error! No API data available for parsing!\n");
		}
		
return nil;
}
