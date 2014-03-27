//
//  EVModelController.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "EVModelController.h"

@implementation EVModelController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

+ (instancetype)sharedModelController {
    static EVModelController *_sharedModelController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModelController = [EVModelController new];
    });
    
    return _sharedModelController;
}

- (id)entityForName:(NSString *)name
{
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
}

#pragma mark - Data fetchers

- (User *)currentUser
{
    // TODO: Get real current user
    return [[self allInstancesOf:@"User" where:nil isEqualto:nil orderedBy:nil] firstObject];
}

- (NSArray *)studyingCourseSteps
{
    // TODO: Get real studying courses steps
    return [self allInstancesOf:@"CourseStep" where:nil isEqualto:nil orderedBy:nil];
}

#pragma mark - Progress

- (CourseStepProgress *)progressForCourseStep:(CourseStep *)courseStep andUser:(User *)user
{
    NSSet *progresses = user.courseStepProgresses;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseStep.identifier LIKE %@", courseStep.identifier];
    NSSet *filteredProgresses = [progresses filteredSetUsingPredicate:predicate];
    CourseStepProgress *courseStepProgress = nil;
    if ([filteredProgresses count] > 0) {
        courseStepProgress = [filteredProgresses allObjects][0];
    }
    
    return courseStepProgress;
}


#pragma mark - Data fetchers / helpers

- (NSArray *)allInstancesOf:(NSString *)entityName
                      where:(NSString *)condition
                  isEqualto:(id)value
                  orderedBy:(NSString *)property
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error: Couldn't fetch: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:entityName
                                               inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // If 'condition' is not nil, limit results to that condition
    if (condition && value)
    {
        NSPredicate *pred;
        if([value isKindOfClass:[NSManagedObject class]])
        {
            value = [((NSManagedObject *)value) objectID];
            pred = [NSPredicate predicateWithFormat:@"(%@ = %@)", condition, value];
        } else if ([value isKindOfClass:[NSString class]])
        {
            NSString *format  = [NSString stringWithFormat:@"%@ LIKE '%@'", condition, value];
            pred = [NSPredicate predicateWithFormat:format];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            NSString *format  = [NSString stringWithFormat:@"%@ == %i", condition, [value intValue]];
            pred = [NSPredicate predicateWithFormat:format];
        }
        else {
            NSString *format  = [NSString stringWithFormat:@"%@ == %@", condition, value];
            pred = [NSPredicate predicateWithFormat:format];
        }
        [fetchRequest setPredicate:pred];
    }
    
    // If 'property' is not nil, have the results sorted
    if (property)
    {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:property
                                                           ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest
                                                     error:&error];
    
    return fetchedObjects;
}

- (NSArray *)allInstancesOf:(NSString *)entityName
withPairColumnValueConditions:(NSDictionary *)columns
                  orderedBy:(NSString *)property
                      limit:(NSUInteger)limit
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error: Couldn't fetch: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:entityName
                                               inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // If 'columns' is not nil, limit results to that condition
    if (columns)
    {
        __block NSString *format  = [NSString string];
        [columns enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id object = [obj isKindOfClass:[NSString class]] ? [NSString stringWithFormat:@"'%@'", obj] : obj;
            format  = [format stringByAppendingFormat:@"(%@ %@) AND ", key, object];
        }];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:[format substringToIndex:format.length -  5]];
        [fetchRequest setPredicate:pred];
    }
    
    // If 'property' is not nil, have the results sorted
    if (property)
    {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:property
                                                           ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest
                                                     error:&error];
    
    return fetchedObjects;
}

- (id)singleInstanceOf:(NSString *)entityName where:(NSString *)condition isEqualTo:(id)value
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error: Couldn't fetch: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:entityName
                                               inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // If 'condition' is not nil, limit results to that condition
    if (condition && value)
    {
        NSPredicate *pred;
        if([value isKindOfClass:[NSManagedObject class]])
        {
            value = [((NSManagedObject *)value) objectID];
            pred = [NSPredicate predicateWithFormat:@"(%@ = %@)", condition, value];
        } else if ([value isKindOfClass:[NSString class]])
        {
            NSString *format  = [NSString stringWithFormat:@"%@ LIKE '%@'", condition, value];
            pred = [NSPredicate predicateWithFormat:format];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            NSString *format  = [NSString stringWithFormat:@"%@ == %i", condition, [value intValue]];
            pred = [NSPredicate predicateWithFormat:format];
        }
        else {
            NSString *format  = [NSString stringWithFormat:@"%@ == %@", condition, value];
            pred = [NSPredicate predicateWithFormat:format];
        }
        [fetchRequest setPredicate:pred];
    }
    [fetchRequest setFetchLimit:1];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest
                                                     error:&error];
    
    return [fetchedObjects count] > 0 ? [fetchedObjects objectAtIndex:0] : nil;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)clearEntityData:(NSArray *)entities
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    for (NSString *entity in entities) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:entity
                                       inManagedObjectContext:context]];
        [request setIncludesPropertyValues:NO];
        
        NSError *error = nil;
        NSArray *data = [context executeFetchRequest:request error:&error];
        
        for (NSManagedObject *element in data)
        {
            [context deleteObject:element];
        }
    }
    
    NSError *saveError;
    if (![context save:&saveError])
    {
        NSLog(@"ERROR: Clearing data failed");
    }
}

- (void)deleteEntity:(NSManagedObject *)entity
{
    [self.managedObjectContext deleteObject:entity];
    [self saveContext];
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LearningAppModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *localStore = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LearningApp.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[localStore path]]) {
        
        NSURL *defaultStorePath = [[NSBundle mainBundle] URLForResource:@"LearningApp"
                                                          withExtension:@"sqlite"];
        
        if (defaultStorePath)
        {
            NSError *error;
            [fileManager copyItemAtURL:defaultStorePath toURL:localStore error:&error];
        }
    }
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES],
                             NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES],
                             NSInferMappingModelAutomaticallyOption,
                             nil];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localStore options:options error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
