//
//  ContentView.m
//  ChatTextView
//
//  Created by iFlyLabs on 06/08/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import "ContentView.h"

static CGFloat kDefaultAnimationDuration = 0.5;
static NSInteger kMinimumNumberOfLines = 1;
static NSInteger kMaximumNumberOfLines = 3;

@interface ContentView() <UITextViewDelegate>

@property (nonatomic, strong) NSLayoutConstraint *chatTextViewHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentViewHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentViewBottomConstraint;
@property (nonatomic, assign) CGFloat initialHeight;
@property (nonatomic, assign) CGFloat maximumHeight;
@property (nonatomic, assign) NSInteger maximumNumberOfLines;
@property (nonatomic, assign) NSInteger minimumNumberOfLines;

@end

@implementation ContentView

@synthesize chatTextView;

-(id)initWithTextView:(UITextView *)textView ChatTextViewHeightConstraint:(NSLayoutConstraint *)chatTextViewHeightConstraint contentView:(UIView *)contentView ContentViewHeightConstraint:(NSLayoutConstraint *)contentViewHeightConstraint andContentViewBottomConstraint:(NSLayoutConstraint *)contentViewBottomConstraint
{
    self = [super init];
    
    if(self)
    {
        chatTextView = textView;
        
        self.chatTextViewHeightConstraint = chatTextViewHeightConstraint;
        
        self.contentView = contentView;
        
        self.contentViewHeightConstraint = contentViewHeightConstraint;
        
        self.contentViewBottomConstraint = contentViewBottomConstraint;
        
        [self addKeyboardNotificationsObserver];
        
        chatTextView.delegate = self;
        
        [self updateMinimumNumberOfLines:kMinimumNumberOfLines andMaximumNumberOfLine:kMaximumNumberOfLines];
    }
    
    return self;
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self resizeTextViewWithAnimation:NO];
}

-(void)updateMinimumNumberOfLines:(NSInteger)minimumNumberOfLines
           andMaximumNumberOfLine:(NSInteger)maximumNumberOfLines
{
    self.minimumNumberOfLines = minimumNumberOfLines;
    self.maximumNumberOfLines = maximumNumberOfLines;
    self.animationDuration = kDefaultAnimationDuration;
    
    [self updateInitialHeightAndResize];
}

- (void)updateInitialHeightAndResize
{
    //getting initial height
    self.initialHeight = [self estimatedInitialHeight];
    self.maximumHeight = [self estimatedMaximumHeight];
    
    [self resizeTextViewWithAnimation:NO];
}


-(NSInteger)estimatedInitialHeight
{
    CGFloat totalHeight = [self caretHeight] * self.minimumNumberOfLines + self.chatTextView.textContainerInset.top + self.chatTextView.textContainerInset.bottom;
    //CGFloat totalHeight = [self caretHeight] * self.minimumNumberOfLines;
    //return fmax(totalHeight,self.chatTextView.frame.size.height);
    return totalHeight;
}

- (CGFloat)estimatedMaximumHeight
{
    CGFloat totalHeight = [self caretHeight] * self.maximumNumberOfLines + self.chatTextView.textContainerInset.top + self.chatTextView.textContainerInset.bottom;
    //CGFloat totalHeight = [self caretHeight] * self.maximumNumberOfLines;
    return totalHeight;
}

- (CGFloat)caretHeight
{
    return [self.chatTextView caretRectForPosition:self.chatTextView.selectedTextRange.end].size.height - 1.5;
}

- (void)resizeTextViewWithAnimation:(BOOL)animated
{
    //get current number of lines
    NSInteger textViewCurrentNumberOfLines = [self currentNumberOfLines];
    
    CGFloat verticalAlignmentConstant = 0.0;
    
    if (textViewCurrentNumberOfLines <= self.minimumNumberOfLines)
    {
        verticalAlignmentConstant = self.initialHeight;
    }
    else if ((textViewCurrentNumberOfLines > self.minimumNumberOfLines) && (textViewCurrentNumberOfLines <= self.maximumNumberOfLines))
    {
        CGFloat currentHeight = [self currentHeight];
        
        verticalAlignmentConstant = (currentHeight > self.initialHeight) ? currentHeight : self.initialHeight;
    }
    else if (textViewCurrentNumberOfLines > self.maximumNumberOfLines)
    {
        verticalAlignmentConstant = self.maximumHeight;
    }
    
    if (self.chatTextViewHeightConstraint.constant != verticalAlignmentConstant)
    {
        [self updateVerticalAlignmentWithHeight:verticalAlignmentConstant animated:animated];
    }
    
    if (textViewCurrentNumberOfLines <= self.maximumNumberOfLines)
    {
        [self.chatTextView setContentOffset:CGPointZero animated:YES];
    }
}

-(NSInteger)currentNumberOfLines
{
    //get height of one line = caret height
    CGFloat caretHeight = [self caretHeight];
    
    //get current height of textView
    CGFloat currentHeight = [self currentHeight];
    
    //CGFloat totalHeight = currentHeight + self.chatTextView.textContainerInset.top + self.chatTextView.textContainerInset.bottom;
    
    CGFloat totalHeight = currentHeight;
    
    NSInteger currentNumberOfLines = (totalHeight/caretHeight);
    
    return currentNumberOfLines;
}

-(CGFloat)currentHeight
{
    CGFloat width = self.chatTextView.bounds.size.width - 2.0 * self.chatTextView.textContainer.lineFragmentPadding;
    CGRect boundingRect = [self.chatTextView.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                            attributes:@{ NSFontAttributeName:self.chatTextView.font}
                                                               context:nil];
    
    CGFloat heightByBoundingRect = CGRectGetHeight(boundingRect);
    
    //CGFloat currentHeight = heightByBoundingRect + self.chatTextView.font.lineHeight;
    
    CGFloat currentHeight = heightByBoundingRect + self.chatTextView.textContainerInset.top + self.chatTextView.textContainerInset.bottom;
    
    return currentHeight;
    
}

- (void)updateVerticalAlignmentWithHeight:(CGFloat)height animated:(BOOL)animated
{
    CGFloat originY = CGRectGetMaxY(self.contentView.frame) - self.contentViewHeightConstraint.constant;
    
    CGFloat oldContentViewHeightConstraint = self.contentViewHeightConstraint.constant;
    
    self.chatTextViewHeightConstraint.constant = height;
    
    self.contentViewHeightConstraint.constant = height + 16;
    
    CGRect newContentViewFrame = CGRectMake(self.contentView.frame.origin.x, originY - (self.contentViewHeightConstraint.constant - oldContentViewHeightConstraint)/2, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.contentView.frame = newContentViewFrame;
    
    
    if (animated == true) {
        [UIView animateWithDuration:kDefaultAnimationDuration
                         animations:^{
                             [self.chatTextView.superview layoutIfNeeded];
                         }
                         completion:nil];
    }
    else {
        [self.chatTextView.superview layoutIfNeeded];
    }
}

- (void)addKeyboardNotificationsObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    
    NSDictionary* info = [paramNotification userInfo];
    
    //when switching languages keyboard might change its height (emoji keyboard is higher than most keyboards).
    //You can get both sizes of the previous keyboard and the new one from info dictionary.
    
    // size of the keyb that is about to disappear
    __unused CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // size of the keyb that is about to appear
    CGSize kbSizeNew = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //make adjustments to constraints here...
    
    self.contentViewBottomConstraint.constant = kbSizeNew.height;
    
    //Magick!
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[info[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // work
    [self.chatTextView.superview.superview layoutIfNeeded];
    
    [UIView commitAnimations];
    
}


- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    NSDictionary* info = [paramNotification userInfo];
    
    //adjust constraints
    
    self.contentViewBottomConstraint.constant = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[info[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // work
    [self.chatTextView.superview.superview layoutIfNeeded];
    
    [UIView commitAnimations];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
