#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "ASRPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    //注册自己的插件
    [ASRPlugin registerWithRegistrar:[self registrarForPlugin:@"AsrPlugin"]];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
