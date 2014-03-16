//
//  Select_Random_Items.h
//  Select Random Items
//
//  Created by Thomas Chester on 3/13/14.
//  Copyright (c) 2014 Thomas Chester. All rights reserved.
//

#import <Automator/AMBundleAction.h>

@interface Select_Random_Items : AMBundleAction

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

- (long)convertToNumber:(long)thisPercentage ofTotal:(long)value;

@end
