#import "hardware.h"

NSString *devicemodel();
 NSString *systemName();

NSString *systemversion();
NSString *devicetype();
NSString *devicecommonname();


int main()
{

printf("%s", [systemVersion UTF8String]);
return 0;
}
