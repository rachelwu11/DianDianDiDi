//
//  HeaderView.m
//  DianDianDiDi
//
//  Created by rachel on 3/18/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

+(id)headerView:(CGRect)frame {
    HeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil].firstObject;
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame = frame;
    return headerView;
}

@end
