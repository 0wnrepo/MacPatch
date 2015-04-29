//
//  DatabaseVC.m
//  MPServerAdmin
//
//  Created by Heizer, Charles on 1/8/15.
//  Copyright (c) 2015 Charles Heizer. All rights reserved.
//

#import "DatabaseVC.h"
#import <ServiceManagement/ServiceManagement.h>
#import "Constants.h"
#import "Common.h"
#import "HelperTool.h"

@interface DatabaseVC () {
    AuthorizationRef    _authRef;
    BOOL _textChanged;
}

@property (atomic, copy,   readwrite) NSData *authorization;
@property (atomic, strong, readwrite) NSXPCConnection *helperToolConnection;

@property (strong) NSDictionary *dbConfig;
@property (strong) NSDictionary *dbConfigRO;

- (void)readDBSettings;

@end

@implementation DatabaseVC

@synthesize dbConfig = _dbConfig;
@synthesize dbConfigRO = _dbConfigRO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _textChanged = FALSE;
    
    OSStatus                    err;
    AuthorizationExternalForm   extForm;
    
    // Create our connection to the authorization system.
    //
    // If we can't create an authorization reference then the app is not going to be able
    // to do anything requiring authorization.  Generally this only happens when you launch
    // the app in some wacky, and typically unsupported, way.  In the debug build we flag that
    // with an assert.  In the release build we continue with self->_authRef as NULL, which will
    // cause all authorized operations to fail.
    
    err = AuthorizationCreate(NULL, NULL, 0, &self->_authRef);
    if (err == errAuthorizationSuccess) {
        err = AuthorizationMakeExternalForm(self->_authRef, &extForm);
    }
    if (err == errAuthorizationSuccess) {
        self.authorization = [[NSData alloc] initWithBytes:&extForm length:sizeof(extForm)];
    }
    assert(err == errAuthorizationSuccess);
    
    // If we successfully connected to Authorization Services, add definitions for our default
    // rights (unless they're already in the database).
    
    if (self->_authRef) {
        [Common setupAuthorizationRights:self->_authRef];
    }
    
    [self readDBSettings];
}

- (void)viewDidAppear
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidEnd:)
                                                 name:NSControlTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidChange:)
                                                 name:NSControlTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:)
                                                 name:NSTextDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:)
                                                 name:NSTextDidEndEditingNotification
                                               object:nil];
    
    [self readDBSettings];
}

- (void)viewDidDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Helper Tool
- (void)connectToHelperTool
// Ensures that we're connected to our helper tool.
{
    assert([NSThread isMainThread]);
    
    if (self.helperToolConnection == nil) {
        self.helperToolConnection = [[NSXPCConnection alloc] initWithMachServiceName:kHelperToolMachServiceName options:NSXPCConnectionPrivileged];
        self.helperToolConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HelperToolProtocol)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        // We can ignore the retain cycle warning because a) the retain taken by the
        // invalidation handler block is released by us setting it to nil when the block
        // actually runs, and b) the retain taken by the block passed to -addOperationWithBlock:
        // will be released when that operation completes and the operation itself is deallocated
        // (notably self does not have a reference to the NSBlockOperation).
        self.helperToolConnection.invalidationHandler = ^{
            // If the connection gets invalidated then, on the main thread, nil out our
            // reference to it.  This ensures that we attempt to rebuild it the next time around.
            self.helperToolConnection.invalidationHandler = nil;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.helperToolConnection = nil;
                NSLog(@"connection invalidated");
            }];
        };
#pragma clang diagnostic pop
        [self.helperToolConnection resume];
    }
}

- (void)connectAndExecuteCommandBlock:(void(^)(NSError *))commandBlock
// Connects to the helper tool and then executes the supplied command block on the
// main thread, passing it an error indicating if the connection was successful.
{
    assert([NSThread isMainThread]);
    
    // Ensure that there's a helper tool connection in place.
    
    [self connectToHelperTool];
    
    // Run the command block.  Note that we never error in this case because, if there is
    // an error connecting to the helper tool, it will be delivered to the error handler
    // passed to -remoteObjectProxyWithErrorHandler:.  However, I maintain the possibility
    // of an error here to allow for future expansion.
    
    commandBlock(nil);
}

#pragma mark - Main

- (void)readDBSettings
{
    [self connectAndExecuteCommandBlock:^(NSError * connectError)
     {
         if (connectError != nil)
         {
             NSLog(@"Error: %@",connectError.localizedDescription);
         }
         else
         {
             [[self.helperToolConnection remoteObjectProxyWithErrorHandler:^(NSError * proxyError) {
                 NSLog(@"Error: %@",proxyError.localizedDescription);
             }] readDBConf:self.authorization withReply:^(NSError * commandError, NSDictionary *dbDict) {
                 if (commandError != nil) {
                     NSLog(@"Error: %@",commandError.localizedDescription);
                 } else {
                     NSLog(@"%@",dbDict);
                     if ([dbDict objectForKey:@"prod"]) {
                         NSDictionary *prd = [dbDict objectForKey:@"prod"];
                         self.dbHostName.stringValue = [prd objectForKey:@"dbHost"] ? : @"localhost";
                         self.dbPort.stringValue = [prd objectForKey:@"dbPort"] ? : @"3306";
                         self.dbName.stringValue = [prd objectForKey:@"dbName"] ? : @"MacPatchDB";
                         self.dbUser.stringValue = [prd objectForKey:@"username"] ? : @"mpdbadm";
                         self.dbUserPass.stringValue = [prd objectForKey:@"password"] ? : @"";
                         self.dbMaxConnections.stringValue = [prd objectForKey:@"maxconnections"] ? : @"500";
                     }
                     if ([dbDict objectForKey:@"ro"]) {
                         NSDictionary *ro = [dbDict objectForKey:@"ro"];
                         self.dbUserRO.stringValue = [ro objectForKey:@"username"];
                         self.dbUserROPass.stringValue = [ro objectForKey:@"password"] ? : @"";
                     }
                 }
                 
                 dispatch_async(dispatch_get_main_queue(),^{[self.view display];});
             }];
         }
     }];
}

#pragma mark - Notifications

// somewhere else in the .m file
- (void)editingDidChange:(NSNotification *)notification
{
    _textChanged = TRUE;
}

- (void)editingDidEnd:(NSNotification *)notification
{
    if (_textChanged == TRUE)
    {
        NSMutableDictionary *database = [NSMutableDictionary new];
        NSMutableDictionary *prdDict = [NSMutableDictionary new];
        [prdDict setObject:self.dbHostName.stringValue forKey:@"dbHost"];
        [prdDict setObject:self.dbPort.stringValue forKey:@"dbPort"];
        [prdDict setObject:self.dbName.stringValue forKey:@"dbName"];
        [prdDict setObject:self.dbUser.stringValue forKey:@"username"];
        [prdDict setObject:self.dbUserPass.stringValue forKey:@"password"];
        [prdDict setObject:self.dbMaxConnections.stringValue forKey:@"maxconnections"];
        [database setObject:prdDict forKey:@"prod"];
        
        NSMutableDictionary *roDict = [NSMutableDictionary new];
        [roDict setObject:self.dbHostName.stringValue forKey:@"dbHost"];
        [roDict setObject:self.dbPort.stringValue forKey:@"dbPort"];
        [roDict setObject:self.dbName.stringValue forKey:@"dbName"];
        [roDict setObject:self.dbUserRO.stringValue forKey:@"username"];
        [roDict setObject:self.dbUserROPass.stringValue forKey:@"password"];
        [database setObject:roDict forKey:@"ro"];
        
        [self connectAndExecuteCommandBlock:^(NSError * connectError)
         {
             if (connectError != nil) {
                 NSLog(@"Error: %@",connectError.localizedDescription);
             } else {
                 [[self.helperToolConnection remoteObjectProxyWithErrorHandler:^(NSError * proxyError) {
                     NSLog(@"Error: %@",proxyError.localizedDescription);
                 }] writeDBConf:self.authorization dbConf:database withReply:^(NSError * commandError, NSString *licenseKey) {
                     if (commandError != nil) {
                         NSLog(@"Error: %@",commandError.localizedDescription);
                     } else {
                         //NSLog(@"%@",licenseKey);
                     }
                 }];
             }
         }];
        
        _textChanged = FALSE;
    }
}

- (void)textDidChange:(NSNotification *)notification
{
    _textChanged = TRUE;
}

- (void)textDidEndEditing:(NSNotification *)notification
{
   
}

@end