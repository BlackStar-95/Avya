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

//implement the alertivator
@implementation Alertivator
// when calling the gesture
- (void)activator:(LAActivator *)activator 
     receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
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
//thread to sleep and then change the bool idEnabed to NO
- (void) waitingTimer {
	//NSLog(@"FoundBS: %f", timerFromPref*60.0);
	//change from min to sec and sleep...
	[NSThread sleepForTimeInterval: timerFromPref*60.0];
	isEnabaled = NO;
    //[pool release]; 
	}
@end

//Hooking into the notification, if avya is enabled && activator bool isEnabled disable the banners else %orig
%hook BBServer
-(void)publishBulletin:(BBBulletin *)arg1 destinations:(unsigned long long)arg2 {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id status = [ bundleDefaults valueForKey:@"status"];
	id isBlacklist = [ bundleDefaults valueForKey:@"isBlacklist"];

	if ((![status isEqual:@0])&&isEnabaled) {
		if (![isBlacklist isEqual:@0]){
			if([SparkAppList doesIdentifier:@"com.blackstar.testpref" andKey:@"excludedApps" containBundleIdentifier:arg1.sectionID]){
				//NSLog(@"Blacklist is on and this app is blacklisted");
			}else{
				//NSLog(@"Blacklist is on and this app is Not blacklisted");
				%orig;
			}
		}else{
		//NSLog(@"Blacklist is OFF Block all Apss");
		}
	}
	else {
		//NSLog(@"Avya is Off");
 		%orig;
	}


	/*if ((![isBlacklist isEqual:@0])&&(![status isEqual:@0])&&(isEnabaled)&&([SparkAppList doesIdentifier:@"com.blackstar.testpref" andKey:@"excludedApps" containBundleIdentifier:arg1.sectionID])){
		NSLog(@"Blacklist working");
	}
	else if ((![status isEqual:@0]) && (isEnabaled) && ([isBlacklist isEqual:@0])) {
		NSLog(@"blacklist is off");
	}else {
 		%orig;
	}*/
}
%end
//Abbilty to add the Enable/Disable Avya into the activator 
static Alertivator *alertivatorInstance;
%ctor{
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.blackstar.AvyaPre"];
    alertivatorInstance = [[Alertivator alloc] init];
    [[LAActivator sharedInstance] registerListener:alertivatorInstance 
                                           forName:@"Enable/Disable Avya"];
	[preferences registerFloat:&timerFromPref default:1 forKey:@"timeinmin"];
}



