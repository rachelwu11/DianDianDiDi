//
//  AlbumView.m
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "AlbumView.h"

@interface AlbumView()

@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation AlbumView

-(id)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:self.coverImage];

        self.indicator = [[UIActivityIndicatorView alloc] init];
        self.indicator.center = self.center;
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self.indicator startAnimating];
        [self addSubview:self.indicator];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification" object:self userInfo:@{@"imageView": self.coverImage, @"coverUrl": albumCover}];
    }
    return self;
}

@end
