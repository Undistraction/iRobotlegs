#import <Foundation/Foundation.h>
#import "JSObjectionInjector.h"
#import "JSObjectionEntry.h"

@interface JSObjection : NSObject {
    
}

+ (JSObjectionInjector *)createInjector:(JSObjectionModule *)aModule;
+ (JSObjectionInjector *)createInjector;
+ (void)registerClass:(Class)theClass lifeCycle:(JSObjectionInstantiationRule)lifeCycle;
+ (void)setGlobalInjector:(JSObjectionInjector *)anInjector;
+ (JSObjectionInjector *)globalInjector;
+ (void)reset;

+ (void) registerClass:(Class)theClass;
+ (void) registerSingletonClass:(Class)theClass;
+ (void) removeClass:(Class)theClass;
+ (void) removeProtocol:(Protocol *)theProtocol;
+ (BOOL) hasClass:(Class)theClass;
+ (BOOL) classIsSingleton:(Class)theClass;

@end
