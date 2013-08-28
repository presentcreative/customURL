#import "CustomURLPlugin.h"

@implementation CustomURLPlugin

// The plugin must call super dealloc.
- (void) dealloc {
	[super dealloc];
}

// The plugin must call super init.
- (id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
    [self performSelector:@selector(getTest:) withObject:nil afterDelay:15];

	return self;
}

- (void) initializeWithManifest:(NSDictionary *)manifest appDelegate:(TeaLeafAppDelegate *)appDelegate {
}

- (void)getTest:(id)sender {
    NSLog(@"{CustomURL} Testing URL");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"matchmatch://gameID=12345&playerID=Betty404&Andrew=butt"]];
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:                                                   @"customURLPlugin",@"name",
        @"handleURL", @"method", nil];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"{CustomURL} %@: %@", key, val);
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (void) handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
	@try {
        NSLog(@"url recieved: %@", url);
        NSLog(@"host: %@", [url host]);
        NSLog(@"url path: %@", [url path]);
        NSDictionary *dict = [self parseQueryString:[url host]];
        NSLog(@"query dict: %@", dict);
        [[PluginManager get] dispatchJSEvent:dict];
	}
	@catch (NSException *exception) {
		NSLOG(@"{customURL} Exception while processing event: %@", exception);
	}
}

@end

