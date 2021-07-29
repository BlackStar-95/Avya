#line 1 "Tweak.xm"
#import "Tweak.h"
#include "activatorheaders/libactivator.h"
#import "SparkAppList.h"
#import <AudioToolbox/AudioToolbox.h>
#import <Cephei/HBPreferences.h>

static BOOL isEnabaled = NO;
static CGFloat timerFromPref;

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


- (void)activator:(LAActivator *)activator  receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
		NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
		id timerisEnabled = [ bundleDefaults valueForKey:@"timer"];
    	if(isEnabaled==NO){
			UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UINotificationFeedbackTypeSuccess];
  			[impactGenerator impactOccurred];	
			isEnabaled = YES;
			if (![timerisEnabled isEqual:@0]){
				[self performSelectorInBackground:@selector(waitingTimer) withObject:nil];
			}
		} 
		else {
			UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UINotificationFeedbackTypeError];
  			[impactGenerator impactOccurred];
			isEnabaled = NO;
		}
	}

- (void) waitingTimer {
	
	
	[NSThread sleepForTimeInterval: timerFromPref*60.0];
	isEnabaled = NO;
    
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

#line 60 "Tweak.xm"

static void _logos_method$_ungrouped$BBServer$publishBulletin$destinations$(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BBBulletin * arg1, unsigned long long arg2) {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id status = [ bundleDefaults valueForKey:@"status"];
	id isBlacklist = [ bundleDefaults valueForKey:@"isBlacklist"];

	if ((![status isEqual:@0])&&isEnabaled) {
		if (![isBlacklist isEqual:@0]){
			if([SparkAppList doesIdentifier:@"com.blackstar.testpref" andKey:@"excludedApps" containBundleIdentifier:arg1.sectionID]){
				
			}else{
				
				_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$(self, _cmd, arg1, arg2);
			}
		}else{
		
		}
	}
	else {
		
 		_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$(self, _cmd, arg1, arg2);
	}


	







}


static Alertivator *alertivatorInstance;
static __attribute__((constructor)) void _logosLocalCtor_1cabc320(int __unused argc, char __unused **argv, char __unused **envp){
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.blackstar.AvyaPre"];
    alertivatorInstance = [[Alertivator alloc] init];
    [[LAActivator sharedInstance] registerListener:alertivatorInstance 
                                           forName:@"Enable/Disable Avya"];
	[preferences registerFloat:&timerFromPref default:1 forKey:@"timeinmin"];
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$BBServer = objc_getClass("BBServer"); { MSHookMessageEx(_logos_class$_ungrouped$BBServer, @selector(publishBulletin:destinations:), (IMP)&_logos_method$_ungrouped$BBServer$publishBulletin$destinations$, (IMP*)&_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$);}} }
#line 106 "Tweak.xm"
