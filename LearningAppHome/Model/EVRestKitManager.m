//
//  EVRestKitManager.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import "EVRestKitManager.h"
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@implementation EVRestKitManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Properties

- (NSManagedObjectContext *)managedObjectContext
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    return objectManager.managedObjectStore.mainQueueManagedObjectContext;
}

#pragma mark - Setup

- (void)setup
{
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"LearningAppModel" ofType:@"momd"]];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"LearningAppHome.sqlite"];
    NSPersistentStore __unused *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                              fromSeedDatabaseAtPath:nil
                                                                                   withConfiguration:nil
                                                                                             options:nil
                                                                                               error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:SERVER_URL]];
    objectManager.managedObjectStore = managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    
    
    [self createMappings];
    
//#ifdef DEBUG
//    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
//    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
//#else
    RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
//#endif
}

- (void)createMappings
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    // Class Mapping: CourseStep
    RKEntityMapping *courseStepMapping = [RKEntityMapping mappingForEntityForName:[CourseStep name] inManagedObjectStore:managedObjectStore];
    [courseStepMapping addAttributeMappingsFromDictionary:@{
                                                        @"id": @"identifier",
                                                        @"title": @"title",
                                                        @"description": @"descriptionText"
                                                        }];
    
    RKResponseDescriptor *courseStepDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:courseStepMapping
                                                                                              method:RKRequestMethodGET
                                                                                         pathPattern:RK_SINGLE_GOAL_URL
                                                                                             keyPath:nil
                                                                                         statusCodes:statusCodes];
    

    // Class Mapping: CourseStepItem
    RKEntityMapping *courseStepItemMapping = [RKEntityMapping mappingForEntityForName:[CourseStepItem name] inManagedObjectStore:managedObjectStore];
    [courseStepItemMapping addAttributeMappingsFromDictionary:@{
                                                                @"id": @"identifier",
                                                                @"cue.content.text": @"text",
                                                                @"cue.related.part_of_speech": @"partOfSpeech",
                                                                @"cue.related.transliterations": @"transliterations",
                                                                @"response.content.text": @"meaning"
                                                                }];
    
    RKResponseDescriptor *courseStepItemDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:courseStepItemMapping
                                                                                              method:RKRequestMethodGET
                                                                                         pathPattern:RK_ITEMS_FOR_GOAL_URL
                                                                                             keyPath:@"items"
                                                                                         statusCodes:statusCodes];
    
    
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    [errorMapping addPropertyMapping: [RKAttributeMapping attributeMappingFromKeyPath:@"errors" toKeyPath:@"errorMessage"]];
    
    RKResponseDescriptor *errorResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                                 method:RKRequestMethodAny
                                                                                            pathPattern:nil
                                                                                                keyPath:nil
                                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    
    
    // add descriptors to object manager
    [objectManager addResponseDescriptorsFromArray:@[courseStepDescriptor, courseStepItemDescriptor, errorResponseDescriptor]];
}

@end
