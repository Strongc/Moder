//
//  Coder.h
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModerCoderDelegate <NSObject>

@required

- (void)displayLetter:(NSString *)letter;
- (void)startNewWord:(NSString *)letter;
- (void)appendToCurrentWord:(NSString *)letter;
- (void)recalculateUnitLengthWithNewSignalLength:(NSNumber *)signalLength;

@end

@interface Coder : NSObject
{
    NSMutableArray *_currentLetter;
    NSMutableArray *_currentWord;
    NSMutableArray *_text;
    
    id <ModerCoderDelegate> _delegate;

    int unitLengthInMillis;
}

@property (nonatomic, retain) id <ModerCoderDelegate> delegate;

- (void) addSignal;
- (void) pause;

- (int) timeInMillis:(double)time;
- (NSString *)decodeLetter:(NSArray *)letter;

@end
