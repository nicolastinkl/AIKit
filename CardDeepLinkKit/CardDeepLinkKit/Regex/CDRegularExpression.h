#import <Foundation/Foundation.h>
#import "CDMatchResult.h"

@interface CDRegularExpression : NSRegularExpression

@property (nonatomic, strong) NSArray *groupNames;

+ (instancetype)regularExpressionWithPattern:(NSString *)pattern;

- (CDMatchResult *)matchResultForString:(NSString *)str;

@end
