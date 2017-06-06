#import "FMDatabase.h"

//
// Interface for Database connector
//
@interface DBConnection : NSObject
{
}

+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force;
+ (FMDatabase*)getSharedDatabase;
+ (void)closeDatabase;


+ (void)alert;

@end