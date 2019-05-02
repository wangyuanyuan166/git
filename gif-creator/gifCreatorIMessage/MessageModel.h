//
//  MessageModel.h
//  KIMessage
//
//  Created by GifKMing on 2018/5/5.
//  Copyright © 2018年 KZGifMaker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy  ) NSString *imessageImageURL;
@property (nonatomic,copy  ) NSString *imessageTitle;
@property (nonatomic,copy  ) NSString *imessageURL;
@property (nonatomic,copy  ) NSString *imessageTitleSub;

- (id)initWithDictionary:(NSDictionary*)object;

@end
