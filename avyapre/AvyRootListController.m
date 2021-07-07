#include "AvyRootListController.h"
#import <spawn.h>
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
- (void)respringFunction{
	pid_t pid;
	const char *args[] = {"sbreload", NULL, NULL, NULL};
	posix_spawn(&pid, "usr/bin/sbreload", NULL, NULL, (char *const *)args, NULL);
}
@end
