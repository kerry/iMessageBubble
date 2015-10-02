//
//  ChatCellSettings.m
//  iFlyChatChatView
//
//  Created by iFlyLabs on 27/08/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import "ChatCellSettings.h"

@interface UIColor(HexString)

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end


@implementation UIColor(HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return (CGFloat)hexComponent/255.0f;
}

@end


@implementation ChatCellSettings

UIColor *senderBubbleColor;

UIColor *receiverBubbleColor;

BOOL senderBubbleTail;
BOOL receiverBubbleTail;

UIColor *senderBubbleNameTextColor;

UIColor *receiverBubbleNameTextColor;

UIColor *senderBubbleMessageTextColor;

UIColor *receiverBubbleMessageTextColor;

UIColor *senderBubbleTimeTextColor;

UIColor *receiverBubbleTimeTextColor;

UIFont *senderBubbleNameFontWithSize;
UIFont *senderBubbleMessageFontWithSize;
UIFont *senderBubbleTimeFontWithSize;

UIFont *receiverBubbleNameFontWithSize;
UIFont *receiverBubbleMessageFontWithSize;
UIFont *receiverBubbleTimeFontWithSize;

//Singleton instance
static ChatCellSettings *instance = nil;


+(ChatCellSettings *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        senderBubbleColor = [UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f];
        
        receiverBubbleColor = [UIColor colorWithRed:(223.0f/255.0f) green:(222.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f];
        
        senderBubbleNameTextColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        
        receiverBubbleNameTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        
        senderBubbleMessageTextColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        
        receiverBubbleMessageTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        
        senderBubbleTimeTextColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        
        receiverBubbleTimeTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        
        senderBubbleNameFontWithSize = [UIFont boldSystemFontOfSize:11];
        senderBubbleMessageFontWithSize = [UIFont systemFontOfSize:14];
        senderBubbleTimeFontWithSize = [UIFont systemFontOfSize:11];
        
        receiverBubbleNameFontWithSize = [UIFont boldSystemFontOfSize:11];
        receiverBubbleMessageFontWithSize = [UIFont systemFontOfSize:14];
        receiverBubbleTimeFontWithSize = [UIFont systemFontOfSize:11];
        
        senderBubbleTail = YES;
        
        receiverBubbleTail = YES;
    });
    
    return instance;
}

-(void) setSenderBubbleColor:(UIColor *)color
{
    senderBubbleColor = color;
}

-(void) setReceiverBubbleColor:(UIColor *)color
{
    receiverBubbleColor = color;
}

-(void) setSenderBubbleNameTextColor:(UIColor *)color
{
    senderBubbleNameTextColor = color;
}

-(void) setReceiverBubbleNameTextColor:(UIColor *)color
{
    receiverBubbleNameTextColor = color;
}

-(void) setSenderBubbleMessageTextColor:(UIColor *)color
{
    senderBubbleMessageTextColor = color;
}

-(void) setReceiverBubbleMessageTextColor:(UIColor *)color
{
    receiverBubbleMessageTextColor = color;
}

-(void) setSenderBubbleTimeTextColor:(UIColor *)color
{
    senderBubbleTimeTextColor = color;
}

-(void) setReceiverBubbleTimeTextColor:(UIColor *)color
{
    receiverBubbleTimeTextColor = color;
}

-(void) setSenderBubbleColorHex:(NSString *)HexColor
{
    [self setSenderBubbleColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleNameTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleNameTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleNameTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleNameTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleMessageTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleMessageTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleMessageTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleMessageTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleTimeTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleTimeTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleTimeTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleTimeTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleFontWithSizeForName:(UIFont *)nameFont
{
    senderBubbleNameFontWithSize = nameFont;
}

-(void) setReceiverBubbleFontWithSizeForName:(UIFont *)nameFont
{
    receiverBubbleNameFontWithSize = nameFont;
}

-(void) setSenderBubbleFontWithSizeForMessage:(UIFont *)messageFont
{
    senderBubbleMessageFontWithSize = messageFont;
}

-(void) setReceiverBubbleFontWithSizeForMessage:(UIFont *)messageFont
{
    receiverBubbleMessageFontWithSize = messageFont;
}

-(void) setSenderBubbleFontWithSizeForTime:(UIFont *)timeFont
{
    senderBubbleTimeFontWithSize = timeFont;
}

-(void) setReceiverBubbleFontWithSizeForTime:(UIFont *)timeFont
{
    receiverBubbleTimeFontWithSize = timeFont;
}

-(void) senderBubbleTailRequired:(BOOL)isRequiredOrNot
{
    senderBubbleTail = isRequiredOrNot;
}

-(void) receiverBubbleTailRequired:(BOOL)isRequiredOrNot
{
    receiverBubbleTail = isRequiredOrNot;
}

-(UIColor *) getSenderBubbleColor
{
    return senderBubbleColor;
}

-(UIColor *) getReceiverBubbleColor
{
    return receiverBubbleColor;
}

-(NSArray *) getSenderBubbleTextColor
{
    return @[senderBubbleNameTextColor,senderBubbleMessageTextColor,senderBubbleTimeTextColor];
}

-(NSArray *) getReceiverBubbleTextColor
{
    return @[receiverBubbleNameTextColor,receiverBubbleMessageTextColor,receiverBubbleTimeTextColor];
}

-(NSArray *) getSenderBubbleFontWithSize
{
    return @[senderBubbleNameFontWithSize,senderBubbleMessageFontWithSize,senderBubbleTimeFontWithSize];
}

-(NSArray *) getReceiverBubbleFontWithSize
{
    return @[receiverBubbleNameFontWithSize,receiverBubbleMessageFontWithSize,receiverBubbleTimeFontWithSize];
}

-(BOOL) getSenderBubbleTail
{
    return senderBubbleTail;
}

-(BOOL) getReceiverBubbleTail
{
    return receiverBubbleTail;
}


@end
