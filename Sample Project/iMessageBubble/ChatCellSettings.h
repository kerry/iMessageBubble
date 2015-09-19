//
//  ChatCellSettings.h
//  iFlyChatChatView
//
//  Created by iFlyLabs on 27/08/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ChatCellSettings : NSObject

+(ChatCellSettings *)getInstance;

-(void) setSenderBubbleColor:(UIColor *)color;
-(void) setReceiverBubbleColor:(UIColor *)color;
-(void) setSenderBubbleNameTextColor:(UIColor *)color;
-(void) setReceiverBubbleNameTextColor:(UIColor *)color;
-(void) setSenderBubbleMessageTextColor:(UIColor *)color;
-(void) setReceiverBubbleMessageTextColor:(UIColor *)color;
-(void) setSenderBubbleTimeTextColor:(UIColor *)color;
-(void) setReceiverBubbleTimeTextColor:(UIColor *)color;
-(void) setSenderBubbleColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleColorHex:(NSString *)HexColor;
-(void) setSenderBubbleNameTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleNameTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleMessageTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleMessageTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleTimeTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleTimeTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleFontWithSizeForName:(UIFont *)nameFont;
-(void) setReceiverBubbleFontWithSizeForName:(UIFont *)nameFont;
-(void) setSenderBubbleFontWithSizeForMessage:(UIFont *)messageFont;
-(void) setReceiverBubbleFontWithSizeForMessage:(UIFont *)messageFont;
-(void) setSenderBubbleFontWithSizeForTime:(UIFont *)timeFont;
-(void) setReceiverBubbleFontWithSizeForTime:(UIFont *)timeFont;
-(void) senderBubbleTailRequired:(BOOL)isRequiredOrNot;
-(void) receiverBubbleTailRequired:(BOOL)isRequiredOrNot;
-(UIColor *) getSenderBubbleColor;
-(UIColor *) getReceiverBubbleColor;
-(NSArray *) getSenderBubbleTextColor;
-(NSArray *) getReceiverBubbleTextColor;
-(NSArray *) getSenderBubbleFontWithSize;
-(NSArray *) getReceiverBubbleFontWithSize;
-(BOOL) getSenderBubbleTail;
-(BOOL) getReceiverBubbleTail;

@end
