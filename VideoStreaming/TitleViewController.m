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

@interface TitleViewController ()

@property MPMoviePlayerViewController *mpvc;
@property NSInteger videoIndex;

@end

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
    _videoIndex = [indexPath row];
    Map *mapped = [_arr objectAtIndex:_videoIndex];
    NSURL *m =[NSURL URLWithString:mapped.animeUrl];
    _mpvc = [[MPMoviePlayerViewController alloc] initWithContentURL: m];
    _mpvc.moviePlayer.shouldAutoplay = YES; // optional
    
    // Remove Default Notification Observer
    [[NSNotificationCenter defaultCenter] removeObserver:_mpvc name:MPMoviePlayerPlaybackDidFinishNotification object:_mpvc.moviePlayer];
    // Add Own Notification Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:_mpvc.moviePlayer];
    
    
    
    [self presentMoviePlayerViewControllerAnimated:_mpvc];
}


-(void)movieFinishedPlaying:(NSNotification*)notification {
   
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            if(_videoIndex != ([_arr count] - 1)) {
                _videoIndex = _videoIndex + 1;
                Map *mapped = [_arr objectAtIndex:_videoIndex];
                [_mpvc.moviePlayer setContentURL:[NSURL URLWithString:mapped.animeUrl]];
                [_mpvc.moviePlayer play];
            } else {
                [self dismissMoviePlayerViewControllerAnimated];
            }
            break;
        case MPMovieFinishReasonPlaybackError:
            [self dismissMoviePlayerViewControllerAnimated];
            break;
        case MPMovieFinishReasonUserExited:
            [self dismissMoviePlayerViewControllerAnimated];
            break;
        default:
            break;
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
