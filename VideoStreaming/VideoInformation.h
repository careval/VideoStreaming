//
//  VideoInformation.h
//  VideoStreaming
//
//  Created by Diego on 3/30/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "ViewController.h"

@interface VideoInformation : NSObject


@property(nonatomic) Anime *instance;

+ (id)singleton;
-(void) setInstance:(Anime* ) animated;
-(Anime*) getAnime;

@end
