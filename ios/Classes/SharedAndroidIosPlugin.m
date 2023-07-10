#import "SharedAndroidIosPlugin.h"
@interface ShareData: NSObject <UIActivityItemSource>

@property(readonly,nonatomic , copy ) NSString *text;

- (instancetype)init __attribute__((unavailable)("Use
 initWithSubject:text: instead"));
 @end

 @implementation SharedAndroidIosPlugin
 - (instancetype) init {
  [super doesNotRecognizeSelector:_cmd];
  return nil;
 }

 - (instancetype) initWithText:(NSString *)text {
 self =  [super init];
 if(self){
  _text = text; 
 }
  return self;
 }

 - (nullable id)activityViewController:(nonnull 
 UIActivityViewController *)activityViewController
 itemForActivityType:(nullable UIActivityType)activityType{
  return _text;
 }

 - (nonnull id)activityViewControllerPlaceholderItem:(nonnull 
 UIActivityViewController *)activityViewController
 {
  return @"";
 }


@end
  
@implementation SharedAndroidIosPlugin
 
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"shared_android_ios"
            binaryMessenger:[registrar messenger]];
  SharedAndroidIosPlugin* instance = [[SharedAndroidIosPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"share" isEqualToString:call.method]) {
    NSString *shareText = arguments[@"message"];

    UIViewController*controller = [UIApplication
    sharedApplication].keyWindow.rootViewController;

    ShareData *data = [[ShareData alloc] initWithText:shareText];

    UIActivityViewController *activityViewController = 
    [[UIActivityViewController alloc]
      initWithActivityItems:@[data]
      applicationActivities:nil];
      activityViewController.popoverPresentationController
      .sourceView = controller.view;
      [controller presentViewController:activityViewController
      animated:YES completion:nil];

  
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
