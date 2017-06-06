#import "DBConnection.h"


static FMDatabase *theDatabase = nil;

#define MAIN_DATABASE_NAME @"db.sqlite"

@implementation DBConnection

+ (FMDatabase*)openDatabase:(NSString*)dbFilename
{
    FMDatabase* instance;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbFilename];
    //NSLog(@"got path:%@", path);
    
    instance  = [FMDatabase databaseWithPath:path];
    
    [instance open];
    
    //NSLog(@"open db: done");
    
    return instance;
}

+ (FMDatabase*)getSharedDatabase
{
    if (theDatabase == nil) {
        theDatabase = [self openDatabase:MAIN_DATABASE_NAME];
        if (theDatabase == nil) {
            [DBConnection createEditableCopyOfDatabaseIfNeeded:true];
        }
        
    }
    return theDatabase;
}


+ (void)closeDatabase
{
    if (theDatabase) {        
        [theDatabase close];
        theDatabase = nil;
    }
}

// Creates a writable copy of the bundled default database in the application Documents directory.
+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force
{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:MAIN_DATABASE_NAME];    
    
    if (force) {
        [fileManager removeItemAtPath:writableDBPath error:&error];
    }
    
    // No exists any database file. Create new one.
    //
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) {
        NSLog(@"got fileExistsAtPath:%@", writableDBPath);
        return;
    }
    // The writable database does not exist, so copy the default to the appropriate location.

    //NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:MAIN_DATABASE_NAME ofType:@"sql"];
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:MAIN_DATABASE_NAME];
    
    //NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"DB" ofType:@"sqlite"];
    NSLog(@"got defaultDBPath:%@", defaultDBPath);
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSLog(@"defaultDBPath: %@", defaultDBPath);
        NSLog(@"writableDBPath: %@", writableDBPath);
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

@end
