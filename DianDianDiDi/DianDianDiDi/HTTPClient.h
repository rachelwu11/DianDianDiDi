//
//  HTTPClient.h
//  DianDianDiDi
//
//  Created by rachel on 4/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTTPClient : NSObject

-(id)getRequest:(NSString *)url;
-(id)postRequest:(NSString *)url body:(NSString *)body;
-(UIImage *)downloadImage:(NSString *)url;

@end
