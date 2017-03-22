//
//  CustomizedSegmentedControl.h
//  DianDianDiDi
//
//  Created by rachel on 3/19/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomizedSegmentedControl : UIView

@property (nonatomic, strong) void(^titleClicked)(NSInteger index);
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *deselectedColor;
@property (nonatomic, strong) UIView *bottomSliderView;

-(void)setContentOffset:(CGPoint)contentOffset;
-(id)initWithTitles:(NSArray <NSString *> *)titles frame:(CGRect)frame titleClicked:(void(^)(NSInteger index))tClicked;

@end
