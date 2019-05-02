//
//  MessageWordCollectionViewCell.h
//  KIMessage
//
//  Created by Ntgod on 2019/1/10.
//  Copyright © 2019年 KUIWebViewDemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageWordCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MessageModel *msgModel;

@property (nonatomic,strong,readonly) UILabel *cellLabel;

@end

NS_ASSUME_NONNULL_END
