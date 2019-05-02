//
//  MessageCollectionViewCell.h
//  KIMessage
//
//  Created by GifKMing on 2018/5/5.
//  Copyright © 2018年 KZGifMaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MessageModel *msgModel;

@property (nonatomic,strong,readonly) UIImage *cellImage;

@end
