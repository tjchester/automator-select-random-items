//
//  Select_Random_Items.m
//  Select Random Items
//
//  Created by Thomas Chester on 3/13/14.
//  Copyright (c) 2014 Thomas Chester. All rights reserved.
//

#import "Select_Random_Items.h"

@implementation Select_Random_Items

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    int selectionMethod = [[[self parameters] objectForKey:@"selectionMethod"] intValue];
    int selectionLocation = [[[self parameters] objectForKey:@"selectionLocation"] intValue];
    long numberToSelect = [[[self parameters] objectForKey:@"numberToSelect"] intValue];
    long totalItems = [input count];
    
    NSLog(@"Parameter[selectionMethod] = %d", selectionMethod);
    NSLog(@"Parameter[selectionLocation] = %d", selectionLocation);
    NSLog(@"Parameter[numberToSelect]  = %lu", numberToSelect);
    NSLog(@"Number of items in Input   = %lu", totalItems);
    
    // Validate selectionMethod is either 0 or 1, if not then
    // default to 0 (i.e. Percentage)
    if (1 != selectionMethod && 0 != selectionMethod)
    {
        selectionMethod = 0;
    }
    
    // Validate selectionLocation is either 0, 1, or 2, if not then
    // default to 0 (i.e. Randomly)
    if (2 != selectionLocation && 1 != selectionLocation && 0 != selectionLocation)
    {
        selectionLocation = 0;
    }

    // Validate numberToSelect is greater than or equal to zero,
    // if not then default to 0
    if (0 > numberToSelect)
    {
        numberToSelect = 0;
    }
    
    // Validate that if the selectionMethod is zero (i.e. Percentage)
    // and the value specified is less than or equal to 100, if not
    // then default to 100.
    if (0 == selectionMethod && 100 < numberToSelect)
    {
        numberToSelect = 100;
    }
    
    // Validate that if the selectionMethod is one (i.e. Number) and
    // the value specified is less than or equal to the number of items
    // in the input list, if not then default to the size of the input
    // list.
    if (1 == selectionMethod && numberToSelect > totalItems)
    {
        numberToSelect = totalItems;
    }
    
    // If the selectionMethod is Percentage than convert the specified
    // percentage into an actual number of items out of the list. For
    // example a value of 50% for an input list of 4 items would be
    // converted into the 2 items to choose.
    if (0 == selectionMethod)
    {
        numberToSelect = [self convertToNumber:numberToSelect ofTotal:totalItems];
    }
    
    NSLog(@"Number to select based on selection method = %lu", numberToSelect);

    // Allocate space for the array of output items
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:numberToSelect];
    
    if (0 == selectionLocation)
    {
        // Loop through the list of input items for the number of items to select. Each
        // time through the loop, pick a random index in the input array and move that
        // item into the output array and at the same time reducing the size of the
        // input array by that item since we don't want to choose the same input item
        // more than once (unless it already appears in the input list multiple times).
        for (long i = 0; i < numberToSelect; i++)
        {
            long randomIndex = arc4random_uniform((u_int32_t)[input count]);
            [returnArray addObject:[input objectAtIndex:randomIndex]];
            [input removeObjectAtIndex:randomIndex];
        }
    }
    
    if (1 == selectionLocation)
    {
        // Loop through the list of input items for the number of items to select. Starting
        // at the beginning of the list copy the item from the input to the same index at
        // the output list.
        for (long i = 0; i < numberToSelect; i++)
        {
            [returnArray addObject:[input objectAtIndex:i]];
        }
    }
    
    if (2 == selectionLocation)
    {
        // Loop through the list of input items for the number of items to select. Starting
        // at the end of the list copy backwards from the input to the the output list.
        for (long i = 0; i < numberToSelect; i++)
        {
            long index = [input count] - i;
            [returnArray addObject:[input objectAtIndex:index]];
        }
    }
    
    return returnArray;
}

- (long)convertToNumber:(long)thisPercentage ofTotal:(long)value
{
    long convertedAmount = ceil((thisPercentage * value) / 100.00);
    
    NSLog(@"%lu percent of %lu is %lu items.", thisPercentage, value, convertedAmount);
    
    return convertedAmount;
}

@end
