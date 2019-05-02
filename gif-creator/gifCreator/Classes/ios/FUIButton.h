//
//  FUIButton.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUIButton : UIButton

@property(nonatomic, strong, readwrite) UIColor *buttonColor ;
@property(nonatomic, strong, readwrite) UIColor *shadowColor ;
@property(nonatomic, strong, readwrite) UIColor *highlightedColor ;
@property(nonatomic, strong, readwrite) UIColor *disabledColor ;
@property(nonatomic, strong, readwrite) UIColor *disabledShadowColor ;
@property(nonatomic, readwrite) CGFloat shadowHeight ;
@property(nonatomic, readwrite) CGFloat cornerRadius ;

@end
