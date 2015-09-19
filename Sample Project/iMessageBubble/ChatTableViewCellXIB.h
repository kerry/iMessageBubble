//
//  ChatTableViewCellXIB.h
//  iMessageBubble
//
//  Created by Prateek Grover on 19/09/15.
//  Copyright (c) 2015 Prateek Grover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCellXIB : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chatUserImage;


@end
