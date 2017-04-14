//
//  LibraryAPI.m
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI() {
    PersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    BOOL isOnline;
}

@end

@implementation LibraryAPI

+(LibraryAPI *)sharedInstance {
    static LibraryAPI *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[LibraryAPI alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"BLDownloadImageNotification" object:nil];
    }
    return self;
}

-(NSArray *)getAlbums {
    return [persistencyManager getAlbums];
}

-(void)addAlbum:(Album *)album atIndex:(int)index {
    [persistencyManager addAlbum:album atIndex:index];
    if (isOnline) {
        [httpClient postRequest:@"api/addAlbum" body:[album description]];
    }

}

-(void)deleteAlbumAtIndex:(int)index {
    [persistencyManager deleteAlbumAtIndex:index];
    if (isOnline) {
        [httpClient postRequest:@"api/deleteAlbum" body:[@(index) description]];
    }
}

-(void)downloadImage:(NSNotification *)notification {
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *coverUrl = notification.userInfo[@"coverUrl"];
    imageView.image = [persistencyManager getImage:[coverUrl lastPathComponent]];

    if (imageView.image == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [httpClient downloadImage:coverUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
            });
        });
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
