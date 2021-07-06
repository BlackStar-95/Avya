#line 1 "Tweak.xm"
#import "Tweak.h"
#include "activatorheaders/libactivator.h"
#import <AudioToolbox/AudioToolbox.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/AvyaPre.plist"

static BOOL isEnabaled = NO;

inline int GetPrefInt(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

@class BBContent;
@interface BBContent : NSObject
@property (nonatomic,retain) NSString * message;
@property (nonatomic,retain) NSString * title;
@end

@interface BBBulletin : NSObject
@property (nonatomic,retain) NSString * sectionID;
@property (nonatomic,retain) BBContent * content;
@end

@interface BBServer
-(void)publishBulletin:(id)arg1 destinations:(unsigned long long)arg2 ;
@end

@interface Alertivator : NSObject <LAListener>
@end


@implementation Alertivator

- (void) waitingTimer  {
	
 	
	
	
	[NSThread sleepForTimeInterval: 30.0];
	isEnabaled = NO;
    
 }


- (void)activator:(LAActivator *)activator  receiveEvent:(LAEvent *)event  forListenerName:(NSString *)listenerName{
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id timer = [ bundleDefaults valueForKey:@"timer"];

    if(isEnabaled==NO){
	UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UINotificationFeedbackTypeSuccess];
  	[impactGenerator impactOccurred];	
	isEnabaled = YES;
	if (![timer isEqual:@0]){
	[self performSelectorInBackground:@selector(waitingTimer) withObject:nil];
	}
	}else{
	UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UINotificationFeedbackTypeError];
  	[impactGenerator impactOccurred];
	isEnabaled = NO;
	}
}
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class BBServer; 
static void (*_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$)(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST, SEL, BBBulletin *, unsigned long long); static void _logos_method$_ungrouped$BBServer$publishBulletin$destinations$(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST, SEL, BBBulletin *, unsigned long long); 

#line 64 "Tweak.xm"

static void _logos_method$_ungrouped$BBServer$publishBulletin$destinations$(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BBBulletin * arg1, unsigned long long arg2) {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id status = [ bundleDefaults valueForKey:@"status"];
	if ((![status isEqual:@0])&&isEnabaled) {
	}else {
 		_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$(self, _cmd, arg1, arg2);
	}
}


static Alertivator *alertivatorInstance;
static __attribute__((constructor)) void _logosLocalCtor_74e9d3fc(int __unused argc, char __unused **argv, char __unused **envp){
    alertivatorInstance = [[Alertivator alloc] init];
    [[LAActivator sharedInstance] registerListener:alertivatorInstance 
                                           forName:@"Enable/Disable Avya"];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$BBServer = objc_getClass("BBServer"); { MSHookMessageEx(_logos_class$_ungrouped$BBServer, @selector(publishBulletin:destinations:), (IMP)&_logos_method$_ungrouped$BBServer$publishBulletin$destinations$, (IMP*)&_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$);}} }
#line 83 "Tweak.xm"
