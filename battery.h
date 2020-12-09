// UIKit
#import <UIKit/UIKit.h>

// Battery Information

// Battery Level
float batterylevel()
 {
    // Find the battery level
        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Set up the battery level float
        float batteryLevel = 0.0;
        // Get the battery level
        float batteryCharge = [device batteryLevel];
        
        // Check to make sure the battery level is more than zero
        if (batteryCharge > 0.0f) {
            // Make the battery level float equal to the charge * 100
            batteryLevel = batteryCharge * 100;
        } else {
            // Unable to find the battery level
            return -1;
        }
        
        // Output the battery level
        return batteryLevel;
}
 
// Charging?
bool charging() {
    // Is the battery charging?
        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([device batteryState] == UIDeviceBatteryStateCharging || [device batteryState] == UIDeviceBatteryStateFull) {
            // Device is charging
            return true;
        } else {
            // Device is not charging
            return false;
        }
    }