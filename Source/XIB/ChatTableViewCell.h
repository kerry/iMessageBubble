//
//  ChatTableViewCell.h
//  test
//
//  Created by iFlyLabs on 06/04/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AuthorType) {
    iMessageBubbleTableViewCellAuthorTypeSender = 0,
    iMessageBubbleTableViewCellAuthorTypeReceiver
};

@interface ChatTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *chatUserImage;
@property (strong, nonatomic) UILabel *chatNameLabel;
@property (strong, nonatomic) UILabel *chatTimeLabel;
@property (strong, nonatomic) UILabel *chatMessageLabel;
@property (nonatomic, assign) AuthorType authorType;

@end
