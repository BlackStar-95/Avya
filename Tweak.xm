#import "Tweak.h"
#include "activatorheaders/libactivator.h"

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

- (void)activator:(LAActivator *)activator 
     receiveEvent:(LAEvent *)event 
  forListenerName:(NSString *)listenerName{
    // Show alert here
}

@end

%hook BBServer
-(void)publishBulletin:(BBBulletin *)arg1 destinations:(unsigned long long)arg2 {
	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.blackstar.AvyaPre"];
	id status = [ bundleDefaults valueForKey:@"status"];
	
	if ([status isEqual:@0]) {
	  %orig;
	}else {

	}
}
%end
static Alertivator *alertivatorInstance;

%ctor{
    alertivatorInstance = [[Alertivator alloc] init];
    [[LAActivator sharedInstance] registerListener:alertivatorInstance 
                                           forName:@"Enable / Disable Avya"];
}


