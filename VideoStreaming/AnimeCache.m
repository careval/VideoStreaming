//
//  AnimeCache.m
//  VideoStreaming
//
//  Created by Diego on 3/28/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "AnimeCache.h"
#import "Anime.h"
#import <Parse/Parse.h>
@implementation AnimeCache
static AnimeCache* cache = nil;

+(id) singleton{
    if(cache == nil){
        cache = [[AnimeCache alloc] init];
        cache.cache = [[NSMutableDictionary alloc]init];
    }
       
    return cache;
}

-(void) loadTitles   {
    
    if([cache.cache count] == 0){
        
        PFQuery *query = [PFQuery queryWithClassName:@"Anime"];
        [query setLimit:1000];
        NSArray *arr = [[NSArray alloc] initWithArray:[query findObjects]];
        
        for(int i =0; i < [arr count]; i++){
            PFObject *currentAnime = [arr objectAtIndex:i];
            Anime * anime = [[Anime alloc] init];
            anime.title = currentAnime[@"title"];
            anime.imageurl = currentAnime[@"image"];
            anime.synopsis = currentAnime[@"synopsis"];
            NSString * pattern = @"\"(.*?)\"";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
            
            NSString *input = currentAnime[@"episodes"];
            NSArray *myArray = [regex matchesInString:input options:0 range:NSMakeRange(0, [input length])] ;
            
            NSMutableArray *matches = [NSMutableArray arrayWithCapacity:[myArray count]];
            
            for (NSTextCheckingResult *match in myArray) {
                NSRange matchRange = [match rangeAtIndex:1];
                [matches addObject:[input substringWithRange:matchRange]];
                //NSLog(@"%@", [matches lastObject]);
            }
            
            anime.episodeList = matches;
           
            cache.cache[anime.title] = anime;
        }
        
    }
  
     NSLog(@"sizeL: %lu",[cache.cache count]);
}


@end







/* [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 
 
 if (!error) {
 for(int i=0; i < [objects count]; i++){
 Anime *anime = [[Anime alloc]init ];
 PFObject *currentAnime =[objects objectAtIndex:i];
 anime.title = currentAnime [@"title"];
 anime.imageurl = currentAnime[@"image"];
 anime.synopsis = currentAnime[@"synopsis"];
 
 anime.episodeList = currentAnime[@"episodes"];
 for(int j =0; j < anime.episodeList.count; j++){
 // NSLog(@"title %@",[anime.episodeList objectAtIndex:j] );
 
 }
 cache.cache[anime.title] = anime;
 
 //cell.textLabel.text = anObject.title;
 //  [tableView reloadData];
 
 
 }
 NSLog(@"sizeL: %lu",[cache.cache count]);
 
 
 } else {
 // Log details of the failure
 NSLog(@"Error: %@ %@", error, [error userInfo]);
 }
 }];
 }*/

