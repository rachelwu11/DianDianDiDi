//
//  Album.m
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "Album.h"

@implementation Album

-(id)initWithTitle:(NSString *)title artist:(NSString *)artist coverUrl:(NSString *)coverUrl year:(NSString *)year {
    if (self = [super init]) {
        _title = title;
        _artist = artist;
        _coverUrl = coverUrl;
        _year = year;
    }
    return self;
}

@end
