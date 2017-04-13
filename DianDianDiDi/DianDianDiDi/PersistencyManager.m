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
                       @[[[Album alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png" year:@"1992"],
                         [[Album alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png" year:@"2003"],
                         [[Album alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png" year:@"1999"],
                         [[Album alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png" year:@"2000"],
                         [[Album alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png" year:@"2000"]]];
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
