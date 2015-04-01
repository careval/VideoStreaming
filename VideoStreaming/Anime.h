//
//  Anime.h
//  VideoStreaming
//
//  Created by Diego on 3/28/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Anime : NSObject

@property(nonatomic) NSString *title;
@property(nonatomic) NSString *synopsis;
@property(nonatomic) NSString *imageurl;
@property(nonatomic) NSArray *episodeList;



+(void) loadDictionary;

@end
