#line 1 "Tweak.xm"
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

@class SBDockView; @class BBServer; 
static void (*_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$)(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST, SEL, BBBulletin *, unsigned long long); static void _logos_method$_ungrouped$BBServer$publishBulletin$destinations$(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST, SEL, BBBulletin *, unsigned long long); static void (*_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); 

#line 16 "Tweak.xm"

static void _logos_method$_ungrouped$BBServer$publishBulletin$destinations$(_LOGOS_SELF_TYPE_NORMAL BBServer* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BBBulletin * arg1, unsigned long long arg2) {
  
}



static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, 0);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$BBServer = objc_getClass("BBServer"); { MSHookMessageEx(_logos_class$_ungrouped$BBServer, @selector(publishBulletin:destinations:), (IMP)&_logos_method$_ungrouped$BBServer$publishBulletin$destinations$, (IMP*)&_logos_orig$_ungrouped$BBServer$publishBulletin$destinations$);}Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); { MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP*)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);}} }
#line 27 "Tweak.xm"
