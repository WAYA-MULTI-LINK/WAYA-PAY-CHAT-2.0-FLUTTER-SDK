#import "WayapayPlugin.h"
#if __has_include(<wayapay/wayapay-Swift.h>)
#import <wayapay/wayapay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wayapay-Swift.h"
#endif

@implementation WayapayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWayapayPlugin registerWithRegistrar:registrar];
}
@end
