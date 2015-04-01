//
//  TitleViewController.m
//  VideoStreaming
//
//  Created by Diego on 3/30/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "TitleViewController.h"
#import "AnimeCache.h"
#import "VideoInformation.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Map.h"
@implementation TitleViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [_summ setEditable:false];
    _dict = [[NSMutableDictionary alloc]init];
    VideoInformation *info = [VideoInformation singleton];
    _local = [info getAnime];
    _titleAnime.text = _local.title;
    NSURL *url = [NSURL URLWithString:_local.imageurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    _poster.image = [UIImage imageWithData:data];
    
    _summ.text = _local.synopsis;
    
    
    _arr = [[NSMutableArray alloc]init ];
    for(int i =0; i < [_local.episodeList count]; i++){
        NSString * episodeTitle = [NSString stringWithFormat:@"Episode %i", i+1];
        //Anime *tmp = [_local.episodeList objectAtIndex:i];
        Map *map = [[Map alloc] init];
        map.titleAnime = episodeTitle;
        map.animeUrl = [_local.episodeList objectAtIndex:i];
        [_arr addObject: map];
        
        
    }
    
 
  
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arr count];
}
-(UITableViewCell *) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tkl" forIndexPath:indexPath];
    

    
    
    
    Map *local = [_arr objectAtIndex:[indexPath row]];
    NSString *tmp =  local.titleAnime;
    cell.textLabel.text = tmp;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Map *mapped = [_arr objectAtIndex:[indexPath row]];
    NSURL *m =[NSURL URLWithString:mapped.animeUrl];
    MPMoviePlayerViewController* mpvc =
    [[MPMoviePlayerViewController alloc] initWithContentURL: m];
    mpvc.moviePlayer.shouldAutoplay = YES; // optional
    [self presentMoviePlayerViewControllerAnimated:mpvc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
