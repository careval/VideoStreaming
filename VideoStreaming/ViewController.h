//
//  ViewController.h
//  VideoStreaming
//
//  Created by Diego on 3/28/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimeCache.h"
#import "Anime.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchDisplayDelegate>
@property(nonatomic) NSArray *arr;
@property (nonatomic) NSMutableDictionary *results;
@property(nonatomic)  AnimeCache *list;

@end

