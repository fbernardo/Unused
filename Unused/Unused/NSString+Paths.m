//
//  NSString+Paths.m
//  Unused
//
//  Created by Fábio Bernardo on 8/17/12.
//
//  Taken from SO: http://stackoverflow.com/a/6542181/366492

#import "NSString+Paths.h"

@implementation NSString (Paths)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath {
    NSArray *pathComponents = [self pathComponents];
    NSArray *anchorComponents = [anchorPath pathComponents];
    
    NSInteger componentsInCommon = MIN([pathComponents count], [anchorComponents count]);
    for (NSInteger i = 0, n = componentsInCommon; i < n; i++) {
        if (![[pathComponents objectAtIndex:i] isEqualToString:[anchorComponents objectAtIndex:i]]) {
            componentsInCommon = i;
            break;
        }
    }
    
    NSUInteger numberOfParentComponents = [anchorComponents count] - componentsInCommon;
    NSUInteger numberOfPathComponents = [pathComponents count] - componentsInCommon;
    
    NSMutableArray *relativeComponents = [NSMutableArray arrayWithCapacity:
                                          numberOfParentComponents + numberOfPathComponents];
    for (NSInteger i = 0; i < numberOfParentComponents; i++) {
        [relativeComponents addObject:@".."];
    }
    [relativeComponents addObjectsFromArray:
     [pathComponents subarrayWithRange:NSMakeRange(componentsInCommon, numberOfPathComponents)]];
    return [NSString pathWithComponents:relativeComponents];
}

@end
