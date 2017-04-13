//
//  PersistencyManager.m
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager()

@property (nonatomic, strong) NSMutableArray *albums;

@end

@implementation PersistencyManager

-(id)init {
    if (self = [super init]) {
        self.albums = [NSMutableArray arrayWithArray:
                       @[[[Album alloc] initWithTitle:@"Abbey Road" artist:@"The Beatles" coverUrl:@"http://5.darkroom.shortlist.com/90/d6e7abc85e5b02b0c9578324a203aa12:b4a124b1b1a81be1152fabd58591b81f/abbey-road" year:@"1992"],
                         [[Album alloc] initWithTitle:@"1984" artist:@"Van Halen" coverUrl:@"http://6.darkroom.shortlist.com/90/450ef12c83ded58c54dc9baf2ad717de:3a54b01d79575bf6bc43f746d03c9e67/1984" year:@"2003"],
                         [[Album alloc] initWithTitle:@"Agetis Byrjun" artist:@"Sigur Ros" coverUrl:@"http://1.darkroom.shortlist.com/90/34cf13c65a1a164802d37f78ef4202e8:21004fc030bfc7fa7bd74927ff6c0e44/agaetis-byrjun" year:@"1999"],
                         [[Album alloc] initWithTitle:@"American IV: The man comes around" artist:@"Johnny Cash" coverUrl:@"http://2.darkroom.shortlist.com/90/a39e3be28a7392f1f208a1ece0993e49:cd34afb6141117e4673264d6f876adc6/american-iv-the-man-comes-around" year:@"2000"],
                         [[Album alloc] initWithTitle:@"Draft 7.30" artist:@"Autechre" coverUrl:@"http://3.darkroom.shortlist.com/90/8ac5a8652347d27bc08c709988ed8884:5aabde30eb606442eab15bdf2e191018/draft-7.30" year:@"2000"]]];
    }
    return self;
}

-(NSArray *)getAlbums {
    return [self.albums mutableCopy];

}

-(void)addAlbum:(Album *)album atIndex:(int)index {
    if (index <= self.albums.count) {
        [self.albums insertObject:album atIndex:index];
    } else {
        [self.albums addObject:album];
    }
}

-(void)deleteAlbumAtIndex:(int)index {
    [self.albums removeObjectAtIndex:index];
}

@end
