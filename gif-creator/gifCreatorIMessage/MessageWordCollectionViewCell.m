//
//  MessageWordCollectionViewCell.m
//  KIMessage
//
//  Created by Ntgod on 2019/1/10.
//  Copyright © 2019年 KUIWebViewDemo. All rights reserved.
//

#import "MessageWordCollectionViewCell.h"


@interface MessageWordCollectionViewCell ()
{
    UIActivityIndicatorView *kIndicatorView;
    UILabel *titleLabel;
}
@end

@implementation MessageWordCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
//    [kImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleLabel];
    

}

- (void)setMsgModel:(MessageModel *)msgModel{
    _msgModel = msgModel;
    NSString *Title = _msgModel.imessageTitle;
    
    titleLabel.text = Title;
    
//    [kIndicatorView startAnimating];
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    titleLabel.frame = self.bounds;
//    kIndicatorView.center = CGPointMake(kImageView.frame.size.width*0.5, kImageView.frame.size.height*0.5);
}

- (UILabel*)cellLabel{
    return titleLabel;
}

@end
