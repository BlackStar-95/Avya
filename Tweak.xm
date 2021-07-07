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
- (void) waitingTimer //must fix getting the data from the slider in the pref.....
 {
	//should be fixed...
 	//int newValue = GetPrefInt(@"timeinsec");
	//double interval = newValue / 1.0;
	//for now the timmer is set for 30 secs
	[NSThread sleepForTimeInterval: 30.0];
	isEnabaled = NO;
    //[pool release]; 
 }
- (void)activator:(LAActivator *)activator 
     receiveEvent:(LAEvent *)event 
  		forListenerName:(NSString *)listenerName{
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

%hook BBServer
-(void)publishBulletin:(BBBulletin *)arg1 destinations:(unsigned long long)arg2 {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id status = [ bundleDefaults valueForKey:@"status"];
	if ((![status isEqual:@0])&&isEnabaled) {
	}else {
 		%orig;
	}
}
%end

static Alertivator *alertivatorInstance;
%ctor{
    alertivatorInstance = [[Alertivator alloc] init];
    [[LAActivator sharedInstance] registerListener:alertivatorInstance 
                                           forName:@"Enable/Disable Avya"];
}


