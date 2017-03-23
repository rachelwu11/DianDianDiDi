//
//  CustomizedSegmentedControl.m
//  DianDianDiDi
//
//  Created by rachel on 3/19/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "CustomizedSegmentedControl.h"

#define ButtonTag 111

#define CSColor(r, g, b) [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: 1.0]

void getRGBValue(CGFloat colorArr[3], UIColor *color) {
    unsigned char data[4];
    size_t width = 1, height = 1, bitsPerComponent = 8, bytesPerRow = 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    uint32_t bitmapInfo = 1;
    CGContextRef context = CGBitmapContextCreate(&data, width, height, bitsPerComponent, bytesPerRow, space, bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(space);
    for (NSInteger i = 0; i < 3; i++) {
        colorArr[i] = data[i];
    }
}

@interface CustomizedSegmentedControl()
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UIButton *> *allButtons;
@property (nonatomic, strong) UIButton *selectedButton;

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
    [self setUpBottomSliderView];

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

-(void)setUpBottomSliderView {

    CGFloat w = self.frame.size.width / self.titles.count;
    CGFloat h = self.frame.size.height;
    UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [self addSubview:sliderView];
    self.bottomSliderView = sliderView;
    sliderView.backgroundColor = self.selectedColor;
}

-(void)onButtonClicked:(UIButton *)sender {

    NSInteger selectedIndex = sender.tag - ButtonTag;

    if (self.titleClicked) {
        self.titleClicked(selectedIndex);
    }

    self.selectedButton = self.allButtons[selectedIndex];
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

    CGRect frame = self.bottomSliderView.frame;
    frame.origin.x = contentOffset.x;
    self.bottomSliderView.frame = frame;

    NSMutableArray *buttonArr = [NSMutableArray array];
    for (UIButton *button in self.allButtons) {
        CGFloat overLapWidth = CGRectIntersection(button.frame, self.bottomSliderView.frame).size.width;
        if (overLapWidth > 0) {
            [buttonArr addObject:button];
        }
    }

    if (buttonArr.count > 1) {
        UIButton *leftButton = buttonArr.firstObject;
        UIButton *rightButton = buttonArr.lastObject;

        [leftButton setTitleColor:CSColor([self getRGBValueWithIndex:0 button:leftButton], [self getRGBValueWithIndex:1 button:leftButton], [self getRGBValueWithIndex:2 button:leftButton]) forState:UIControlStateNormal];

        [rightButton setTitleColor:CSColor([self getRGBValueWithIndex:0 button:rightButton], [self getRGBValueWithIndex:1 button:rightButton], [self getRGBValueWithIndex:2 button:rightButton]) forState:UIControlStateNormal];
    }

    //reset selected button
    self.selectedButton = [self viewWithTag:(NSInteger)ButtonTag + self.bottomSliderView.center.x / (self.frame.size.width / self.titles.count)];

}

-(CGFloat)getRGBValueWithIndex:(NSInteger)index button:(UIButton *)button {
    CGFloat leftRGB[3];
    CGFloat rightRGB[3];
    getRGBValue(leftRGB, self.deselectedColor);
    getRGBValue(rightRGB, self.selectedColor);

    CGFloat overLapWidth = CGRectIntersection(button.frame, self.bottomSliderView.frame).size.width;
    CGFloat value = overLapWidth / button.frame.size.width;
    if ([button isEqual:self.selectedButton]) {
        return leftRGB[index] + value * (rightRGB[index] - leftRGB[index]);
    } else {
        return rightRGB[index] + (1 - value) * (leftRGB[index] - rightRGB[index]);
    }

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
