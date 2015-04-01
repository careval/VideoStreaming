//
//  AnimeCache.h
//  VideoStreaming
//
//  Created by Diego on 3/28/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimeCache : NSObject
@property(nonatomic) NSMutableDictionary* cache;
@property(nonatomic) NSInteger* size;

+ (id)singleton;
-(void) loadTitles;

@end
