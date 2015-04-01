//
//  VideoInformation.m
//  VideoStreaming
//
//  Created by Diego on 3/30/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "VideoInformation.h"

@implementation VideoInformation
static VideoInformation* singleton;

+(id) singleton{
    if(singleton == nil){
        singleton = [[VideoInformation alloc] init];
        
       
    }
    
    return singleton;
}


-(void) setInstance:(Anime* ) animated{
    _instance = [[Anime alloc] init ];
    _instance.title= animated.title;
    _instance.synopsis = animated.synopsis;
    _instance.imageurl = animated.imageurl;
    _instance.episodeList = animated.episodeList;
    
}

-(Anime*) getAnime{
    return _instance;
}

@end
