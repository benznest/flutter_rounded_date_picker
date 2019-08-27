#import "FlutterRoundedDatePickerPlugin.h"
#import <flutter_rounded_date_picker/flutter_rounded_date_picker-Swift.h>

@implementation FlutterRoundedDatePickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRoundedDatePickerPlugin registerWithRegistrar:registrar];
}
@end
