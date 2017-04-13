//
//  PersistencyManager.h
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface PersistencyManager : NSObject

-(NSArray *)getAlbums;
-(void)addAlbum:(Album *)album atIndex:(int)index;
-(void)deleteAlbumAtIndex:(int)index;

@end