#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, WKScriptMessageHandler, WKNavigationDelegate>
@property (strong, nonatomic) NSWindow *window;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSTimer *statusTimer;
@property (assign, nonatomic) BOOL isConnected;
@property (assign, nonatomic) BOOL swapCmdOpt;
@property (assign, nonatomic) BOOL swapRightMod;
@property (copy, nonatomic) NSString *capsLockAction;
@property (assign, nonatomic) BOOL launchOnLogin;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    // Load saved preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.swapCmdOpt = [defaults objectForKey:@"swapCmdOpt"] ? [defaults boolForKey:@"swapCmdOpt"] : YES;
    self.swapRightMod = [defaults objectForKey:@"swapRightMod"] ? [defaults boolForKey:@"swapRightMod"] : NO;
    self.capsLockAction = [defaults stringForKey:@"capsLockAction"] ?: @"normal";
    self.launchOnLogin = [defaults boolForKey:@"launchOnLogin"];

    [self setupStatusItem];
    [self setupWindow];
    [self checkDeviceStatus:nil];

    // Auto-apply stored mapping if keyboard is detected
    if (self.isConnected && self.swapCmdOpt) {
        [self executeKeyMapping];
    }

    // Start polling timer for connection status
    self.statusTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                        target:self
                                                      selector:@selector(checkDeviceStatus:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)setupStatusItem {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSButton *button = self.statusItem.button;
    if (button) {
        button.title = @"🐉";
        button.toolTip = @"Redragon Studio — K530 Draconic";
    }
    [self updateMenu];
}

- (void)updateMenu {
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Redragon Menu"];

    NSString *statusStr = self.isConnected ? @"🟢 Redragon K530: Connected" : @"⚪ Redragon K530: Disconnected";
    NSMenuItem *statusMenuItem = [[NSMenuItem alloc] initWithTitle:statusStr action:nil keyEquivalent:@""];
    [statusMenuItem setEnabled:NO];
    [menu addItem:statusMenuItem];

    [menu addItem:[NSMenuItem separatorItem]];

    NSMenuItem *openItem = [[NSMenuItem alloc] initWithTitle:@"Open Redragon Studio..." action:@selector(showWindow:) keyEquivalent:@"o"];
    [openItem setTarget:self];
    [menu addItem:openItem];

    [menu addItem:[NSMenuItem separatorItem]];

    NSMenuItem *cmdOptItem = [[NSMenuItem alloc] initWithTitle:@"Mac Layout (Cmd/Opt Swapped)" action:@selector(toggleCmdOptFromMenu:) keyEquivalent:@""];
    cmdOptItem.state = self.swapCmdOpt ? NSControlStateValueOn : NSControlStateValueOff;
    [cmdOptItem setTarget:self];
    [menu addItem:cmdOptItem];

    NSMenuItem *capsItem = [[NSMenuItem alloc] initWithTitle:@"Caps Lock -> Escape" action:@selector(toggleCapsLockFromMenu:) keyEquivalent:@""];
    capsItem.state = [self.capsLockAction isEqualToString:@"escape"] ? NSControlStateValueOn : NSControlStateValueOff;
    [capsItem setTarget:self];
    [menu addItem:capsItem];

    [menu addItem:[NSMenuItem separatorItem]];

    NSMenuItem *batteryTip = [[NSMenuItem alloc] initWithTitle:@"Check Battery: Press Fn2 + Esc" action:nil keyEquivalent:@""];
    [batteryTip setEnabled:NO];
    [menu addItem:batteryTip];

    [menu addItem:[NSMenuItem separatorItem]];

    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit Redragon Studio" action:@selector(terminate:) keyEquivalent:@"q"];
    [quitItem setTarget:NSApp];
    [menu addItem:quitItem];

    self.statusItem.menu = menu;
}

- (void)setupWindow {
    NSRect frame = NSMakeRect(100, 100, 1120, 800);
    NSUInteger styleMask = NSWindowStyleMaskTitled |
                           NSWindowStyleMaskClosable |
                           NSWindowStyleMaskMiniaturizable |
                           NSWindowStyleMaskResizable |
                           NSWindowStyleMaskFullSizeContentView;

    self.window = [[NSWindow alloc] initWithContentRect:frame
                                              styleMask:styleMask
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    self.window.title = @"Redragon Studio — K530 Draconic Control Center";
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.minSize = NSMakeSize(960, 680);
    self.window.delegate = self;
    self.window.backgroundColor = [NSColor colorWithCalibratedRed:0.07 green:0.08 blue:0.11 alpha:1.0];
    [self.window center];

    // Configure WKWebView
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.websiteDataStore = [WKWebsiteDataStore nonPersistentDataStore];
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addScriptMessageHandler:self name:@"redragonBridge"];
    config.userContentController = userController;
    [config.preferences setValue:@YES forKey:@"developerExtrasEnabled"];

    self.webView = [[WKWebView alloc] initWithFrame:self.window.contentView.bounds configuration:config];
    self.webView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.webView.navigationDelegate = self;
    self.webView.underPageBackgroundColor = [NSColor colorWithCalibratedRed:0.07 green:0.08 blue:0.11 alpha:1.0];

    [self.window.contentView addSubview:self.webView];

    // Load web content
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *htmlPath = [resourcePath stringByAppendingPathComponent:@"web/index.html"];
    
    // Fallback if running directly during development
    if (![[NSFileManager defaultManager] fileExistsAtPath:htmlPath]) {
        htmlPath = @"/Users/adicadi/redragon-mac-studio/web/index.html";
        if (![[NSFileManager defaultManager] fileExistsAtPath:htmlPath]) {
            htmlPath = @"/Users/adicadi/.gemini/antigravity/scratch/redragon-mac-studio/web/index.html";
        }
    }

    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    NSURL *readAccessURL = [fileURL URLByDeletingLastPathComponent];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:readAccessURL];

    [self.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)showWindow:(id)sender {
    [self.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (BOOL)windowShouldClose:(NSWindow *)sender {
    // Hide window instead of terminating so menu bar stays active
    [self.window orderOut:nil];
    return NO;
}

- (void)toggleCmdOptFromMenu:(id)sender {
    self.swapCmdOpt = !self.swapCmdOpt;
    [[NSUserDefaults standardUserDefaults] setBool:self.swapCmdOpt forKey:@"swapCmdOpt"];
    [self executeKeyMapping];
    [self updateMenu];
    [self notifyWebClient];
}

- (void)toggleCapsLockFromMenu:(id)sender {
    if ([self.capsLockAction isEqualToString:@"escape"]) {
        self.capsLockAction = @"normal";
    } else {
        self.capsLockAction = @"escape";
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.capsLockAction forKey:@"capsLockAction"];
    [self executeKeyMapping];
    [self updateMenu];
    [self notifyWebClient];
}

#pragma mark - Device & KeyMapping Logic

- (void)checkDeviceStatus:(NSTimer *)timer {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/hidutil";
    task.arguments = @[@"list"];

    NSPipe *pipe = [NSPipe pipe];
    task.standardOutput = pipe;
    [task launch];
    [task waitUntilExit];

    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // Look for VendorID 0xe (14) and ProductID 0x3412 (13330) or "BT5.0 KB"
    BOOL connected = [output containsString:@"0x3412"] || [output containsString:@"BT5.0 KB"];

    if (connected != self.isConnected) {
        self.isConnected = connected;
        [self updateMenu];
        [self notifyWebClient];
        if (self.isConnected && self.swapCmdOpt) {
            [self executeKeyMapping];
        }
    }
}

- (void)executeKeyMapping {
    NSMutableArray *mappingArray = [NSMutableArray array];

    // Left Alt (0x7000000E2 = 30064771298) <-> Left GUI / Win (0x7000000E3 = 30064771299)
    if (self.swapCmdOpt) {
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x7000000E2),
            @"HIDKeyboardModifierMappingDst": @(0x7000000E3)
        }];
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x7000000E3),
            @"HIDKeyboardModifierMappingDst": @(0x7000000E2)
        }];
    }

    // Right Alt (0x7000000E6 = 30064771302) <-> Right GUI (0x7000000E7 = 30064771303)
    if (self.swapRightMod) {
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x7000000E6),
            @"HIDKeyboardModifierMappingDst": @(0x7000000E7)
        }];
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x7000000E7),
            @"HIDKeyboardModifierMappingDst": @(0x7000000E6)
        }];
    }

    // Caps Lock (0x700000039) -> Escape (0x700000029) or Control (0x7000000E0)
    if ([self.capsLockAction isEqualToString:@"escape"]) {
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x700000039),
            @"HIDKeyboardModifierMappingDst": @(0x700000029)
        }];
    } else if ([self.capsLockAction isEqualToString:@"control"]) {
        [mappingArray addObject:@{
            @"HIDKeyboardModifierMappingSrc": @(0x700000039),
            @"HIDKeyboardModifierMappingDst": @(0x7000000E0)
        }];
    }

    NSDictionary *payload = @{@"UserKeyMapping": mappingArray};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payload options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/hidutil";
    task.arguments = @[
        @"property",
        @"--matching", @"{\"VendorID\": 14, \"ProductID\": 13330}",
        @"--set", jsonString
    ];
    [task launch];
    [task waitUntilExit];

    if (self.launchOnLogin) {
        [self updateLaunchAgentWithJson:jsonString];
    }
}

- (void)resetKeyMapping {
    self.swapCmdOpt = NO;
    self.swapRightMod = NO;
    self.capsLockAction = @"normal";

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"swapCmdOpt"];
    [defaults setBool:NO forKey:@"swapRightMod"];
    [defaults setObject:@"normal" forKey:@"capsLockAction"];

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/hidutil";
    task.arguments = @[
        @"property",
        @"--matching", @"{\"VendorID\": 14, \"ProductID\": 13330}",
        @"--set", @"{\"UserKeyMapping\":[]}"
    ];
    [task launch];
    [task waitUntilExit];

    [self updateMenu];
    [self notifyWebClient];
}

- (void)updateLaunchAgentWithJson:(NSString *)jsonString {
    NSString *launchAgentsDir = [@"~/Library/LaunchAgents" stringByExpandingTildeInPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:launchAgentsDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *plistPath = [launchAgentsDir stringByAppendingPathComponent:@"com.redragon.macstudio.plist"];

    if (!self.launchOnLogin) {
        [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil];
        return;
    }

    NSString *plistContent = [NSString stringWithFormat:
        @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        @"<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
        @"<plist version=\"1.0\">\n"
        @"<dict>\n"
        @"    <key>Label</key>\n"
        @"    <string>com.redragon.macstudio</string>\n"
        @"    <key>ProgramArguments</key>\n"
        @"    <array>\n"
        @"        <string>/usr/bin/hidutil</string>\n"
        @"        <string>property</string>\n"
        @"        <string>--matching</string>\n"
        @"        <string>{\"VendorID\": 14, \"ProductID\": 13330}</string>\n"
        @"        <string>--set</string>\n"
        @"        <string>%@</string>\n"
        @"    </array>\n"
        @"    <key>RunAtLoad</key>\n"
        @"    <true/>\n"
        @"</dict>\n"
        @"</plist>\n", jsonString];

    [plistContent writeToFile:plistPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)notifyWebClient {
    NSDictionary *state = @{
        @"connected": @(self.isConnected),
        @"deviceName": @"Redragon K530 Draconic",
        @"identifier": @"BT5.0 KB",
        @"vendorId": @"0x000E (14)",
        @"productId": @"0x3412 (13330)",
        @"transport": @"Bluetooth Low Energy",
        @"swapCmdOpt": @(self.swapCmdOpt),
        @"swapRightMod": @(self.swapRightMod),
        @"capsLockAction": self.capsLockAction,
        @"launchOnLogin": @(self.launchOnLogin)
    };

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:state options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"if (window.onNativeStateUpdate) { window.onNativeStateUpdate(%@); }", jsonStr];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView evaluateJavaScript:js completionHandler:nil];
    });
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (![message.body isKindOfClass:[NSDictionary class]]) return;
    NSDictionary *body = (NSDictionary *)message.body;
    NSString *action = body[@"action"];

    if ([action isEqualToString:@"getState"]) {
        [self notifyWebClient];
    } else if ([action isEqualToString:@"applyMapping"]) {
        if (body[@"swapCmdOpt"]) self.swapCmdOpt = [body[@"swapCmdOpt"] boolValue];
        if (body[@"swapRightMod"]) self.swapRightMod = [body[@"swapRightMod"] boolValue];
        if (body[@"capsLockAction"]) self.capsLockAction = body[@"capsLockAction"];
        if (body[@"launchOnLogin"]) self.launchOnLogin = [body[@"launchOnLogin"] boolValue];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:self.swapCmdOpt forKey:@"swapCmdOpt"];
        [defaults setBool:self.swapRightMod forKey:@"swapRightMod"];
        [defaults setObject:self.capsLockAction forKey:@"capsLockAction"];
        [defaults setBool:self.launchOnLogin forKey:@"launchOnLogin"];

        [self executeKeyMapping];
        [self updateMenu];
        [self notifyWebClient];
    } else if ([action isEqualToString:@"resetMapping"]) {
        [self resetKeyMapping];
    } else if ([action isEqualToString:@"refreshStatus"]) {
        [self checkDeviceStatus:nil];
    } else if ([action isEqualToString:@"quit"]) {
        [NSApp terminate:nil];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self notifyWebClient];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        app.delegate = delegate;
        [app run];
    }
    return 0;
}
