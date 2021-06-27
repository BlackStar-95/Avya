#include "AvyRootListController.h"

@implementation AvyRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
- (void)openGithub{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/nasrawiziad/Avya"]];
}
- (void)openTwitter{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/BStar_dev"]];
}
@end
