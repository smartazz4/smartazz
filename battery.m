#import <stdbool.h>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <stdio.h>

int batterylevel()
{
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Set up the battery level float
float batteryLevel=0.0;
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
        return                batteryLevel;
    }
bool  ischarging()
{
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
bool fullycharged()
{
    // Is the battery fully charged?

        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([device batteryState] == UIDeviceBatteryStateFull) {
            // Device is fully charged
            return true;
        } else {
            // Device is not fully charged
            return false;
        }
    }
int batterymanager ()
{
   float batteryLevel=batterylevel();
bool   isCharging=ischarging();
bool fullyCharged=fullycharged();
return 0;
}
