//
//  Coder.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Coder.h"
#import "Signal.h"

@implementation Coder

- (id)init
{
    if (self = [super init])
    {
        _data = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSignalWithSignalLength:(double) signalLength
{
    Signal *signal = [[Signal alloc] initWithSignalLength:[self timeInMillis:signalLength]];
    [_data addObject:signal];
    
    [self recalculateUnitLength];
    [self analyzeData];
}

- (void) addPauseWithPauseLength:(double) pauseLength
{
    Signal *signal = [[Signal alloc] initWithPauseLength:[self timeInMillis:pauseLength]];
    [_data addObject:signal];

    [self analyzeData];
}

- (int) timeInMillis:(double) time
{
    int millis = time * 1000;
    return millis;
}

- (void) recalculateUnitLength
{
    int sum = 0;
    Signal *lastSignal = nil;
    
    for (Signal *signal in _data)
    {
        if (signal.tone == YES)
        {
            NSLog(@"Signal Length: %i", signal.length);
            NSLog(@"Last Signal Length: %i", lastSignal.length);
            
            int minLength = lastSignal.length / 2;
            int maxLength = lastSignal.length * 1.5f;
            
            NSLog(@"Min Length: %i, Max Length: %i", minLength, maxLength);
            
            if (signal.length > minLength && signal.length < maxLength)
            {
                NSLog(@"Adding");
                
                sum += signal.length;
                NSLog(@"Sum: %i", sum);
                
                lastSignal = signal;
            }
        }
    }
    
    unitLengthInMillis = sum / 10;
    
    NSLog(@"Unit Length: %i", unitLengthInMillis);
}

- (void) analyzeData
{
    Signal *signal = [_data lastObject];
    NSLog(@"%@", [signal toString]);
}

@end
