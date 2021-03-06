//
//  HistoryViewController.m
//  MacPatch
//
//  Created by Heizer, Charles on 12/16/14.
//  Copyright (c) 2014 Heizer, Charles. All rights reserved.
//

#import "HistoryViewController.h"
#import "DBModels.h"


@interface ActionValueTransformer: NSValueTransformer

@end

@implementation ActionValueTransformer

+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value
{
    NSString *result = @"Error";
    switch ([value integerValue]) {
        case 0:
            result = @"Install";
            break;
        case 1:
            result = @"UnInstall";
            break;
        default:
            break;
    }
    return result;
}
@end

@interface TypeValueTransformer: NSValueTransformer

@end

@implementation TypeValueTransformer

+ (Class)transformedValueClass { return [NSNumber class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value
{
	NSString *result = @"Error";
	switch ([value integerValue]) {
		case 0:
			result = @"Software";
			break;
		case 1:
			result = @"Patch";
			break;
		default:
			break;
	}
	return result;
}
@end


@interface HistoryViewController ()
{
    //DBLocal *db;
    NSMutableArray *historyArray;
	//FMXDatabaseManager *dbManager;
	//FMDatabase *db;
}

@property(nonatomic) IBOutlet NSTableView *tableView;

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    historyArray = [[NSMutableArray alloc] init];
	//dbManager = [FMXDatabaseManager sharedManager];
	//[dbManager registerDefaultDatabaseWithPath:MP_AGENT_DB migration:nil];
	
	// Connect to default database
	//db = [dbManager defaultDatabase];
}

- (void)viewDidAppear
{
    [self loadTableData];
}

- (NSArray *)databaseRecords
{
	//[db open];
	NSMutableArray *array = [NSMutableArray new];
	
	// Query all records
	MPClientDB *db = [MPClientDB new];
	NSArray *records = [db retrieveHistory];
	
	if (records) {
		[arrayController removeObjects:[arrayController arrangedObjects]];
		for (History *hst in records) {
			NSDictionary *d = @{@"install_date":[hst valueForKey:@"cdate"],
								@"type":[hst valueForKey:@"type"],
								@"uuid":[hst valueForKey:@"uuid"],
								@"action":[hst valueForKey:@"action"],
								@"error_code":[hst valueForKey:@"result_code"],
								@"name":[hst valueForKey:@"name"],
								@"error_msg":[hst valueForKey:@"error_msg"] ?:@""
								};
			[array addObject:d];
		}
	}
	
	return [NSArray arrayWithArray:array];
	/*
	NSArray *records = [[DBHistory query] allRecords];
	if (records) {
		[arrayController removeObjects:[arrayController arrangedObjects]];
		for (DBHistory *hst in records) {
			NSDictionary *d = @{@"install_date":[hst valueForKey:@"cdate"],
								@"type":[hst valueForKey:@"type"],
								@"uuid":[hst valueForKey:@"uuid"],
								@"action":[hst valueForKey:@"action"],
								@"error_code":[hst valueForKey:@"result_code"],
								@"name":[hst valueForKey:@"name"],
								@"error_msg":[hst valueForKey:@"error_msg"] ?:@""
								};
			[array addObject:d];
		}
	}
	
	[db close];
	 */
	//return [NSArray arrayWithArray:array];
	
}

- (void)loadTableData
{
	NSArray *array = [self databaseRecords];
	[arrayController removeObjects:[arrayController arrangedObjects]];
	[arrayController addObjects:array];
	[_tableView reloadData];
}

- (IBAction)loadTableUsingType:(id)sender
{
	
    _statusText.stringValue = @"";
    _statusText.hidden = YES;
    _statusImage.hidden = YES;
    
    NSArray *records = [self databaseRecords];
    NSString *_reqType = [sender title];
	
    if ([_reqType isEqualToString:@"Software"])
	{
		records = [records filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)", @(0)]];
    }
    if ([_reqType isEqualToString:@"Patches"])
	{
        records = [records filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(type == %@)", @(1)]];
    }
    
    if (records && [records count] > 0) {
        [arrayController removeObjects:[arrayController arrangedObjects]];
        [arrayController addObjects:records];
        [_tableView reloadData];
    } else {
        _statusText.stringValue = @"No records found.";
        _statusText.hidden = NO;
        _statusImage.image = [NSImage imageNamed:@"WarningImage"];
        _statusImage.hidden = NO;
    }
}

@end
