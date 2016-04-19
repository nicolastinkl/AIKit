#import <Foundation/Foundation.h>

@interface CDMatchResult : NSObject

@property (nonatomic, assign, getter=isMatch) BOOL match;
@property (nonatomic, strong) NSDictionary *namedProperties;

@end
