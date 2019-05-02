//
//  FUITextField.h
//  FlatUI
//
//  Created by Andrej Mihajlov on 8/25/13.
//  Copyright (c) 2013 Andrej Mihajlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUITextField : UITextField

@property (nonatomic, assign) UIEdgeInsets edgeInsets ;
@property (nonatomic, strong) UIColor *textFieldColor ;
@property (nonatomic, strong) UIColor *borderColor ;
@property (nonatomic, assign) CGFloat borderWidth ;
@property (nonatomic, assign) CGFloat cornerRadius ;

@end
