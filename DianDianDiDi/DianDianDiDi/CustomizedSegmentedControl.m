//
//  CustomizedSegmentedControl.m
//  DianDianDiDi
//
//  Created by rachel on 3/19/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "CustomizedSegmentedControl.h"

#define ButtonTag 111

@interface CustomizedSegmentedControl()
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UIButton *> *allButtons;

@end

@implementation CustomizedSegmentedControl

-(id)initWithTitles:(NSArray <NSString *> *)titles frame:(CGRect)frame titleClicked:(void(^)(NSInteger index))tClicked {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.titleClicked = tClicked;
        [self setUpBase];
    }
    return self;
}

-(void)setUpBase {

    [self setUpAllButtons];
    [self onButtonClicked:[self viewWithTag:ButtonTag]];    //default, index 0 is selected

}

-(void)setUpAllButtons {

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width / self.titles.count;
    CGFloat h = self.frame.size.height;

    for (int i = 0; i < self.titles.count; i++) {

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:self.deselectedColor forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.backgroundColor = [UIColor clearColor];
        button.tag = ButtonTag + i;
        x += w;
        [self addSubview:button];
        [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.allButtons addObject:button];
    }
}

-(void)onButtonClicked:(UIButton *)sender {

    NSInteger selectedIndex = sender.tag - ButtonTag;

    if (self.titleClicked) {
        self.titleClicked(selectedIndex);
    }

    [self setUpButtonColorsWithSelectedIndex:selectedIndex];

}

-(void)setUpButtonColorsWithSelectedIndex:(NSUInteger)selectedIndex {
    for (int i = 0; i < self.allButtons.count; i++) {
        if (i == selectedIndex) {
            [self.allButtons[i] setTitleColor:self.selectedColor forState:UIControlStateNormal];
        } else {
            [self.allButtons[i] setTitleColor:self.deselectedColor forState:UIControlStateNormal];
        }
    }
}

-(void)setContentOffset:(CGPoint)contentOffset {

    CGFloat width = self.frame.size.width / self.allButtons.count;

    
}

-(UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}

-(UIColor *)deselectedColor {
    if (!_deselectedColor) {
        _deselectedColor = [UIColor blackColor];
    }
    return _deselectedColor;
}

-(NSMutableArray<UIButton *> *)allButtons {
    if (!_allButtons) {
        _allButtons = [NSMutableArray array];
    }
    return _allButtons;
}

@end
