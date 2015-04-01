//
//  ViewController.m
//  VideoStreaming
//
//  Created by Diego on 3/28/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "ViewController.h"
#import "AnimeCache.h"
#import <Parse/Parse.h>
#import "VideoInformation.h"
@interface ViewController ()

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _results =[[NSMutableDictionary alloc]init];
    
   
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [_results count];
        
    }
    return [_list.cache count];
}
-(UITableViewCell *) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath: indexPath];
   

    Anime* anObject;
   if(tableView == self.searchDisplayController.searchResultsTableView){
        
        NSArray *keys = [_results allKeys];
        NSString* aKey = [keys objectAtIndex:[indexPath row]];
       anObject = [_results objectForKey:aKey];
        cell.textLabel.text = anObject.title;
    }
    else{
        NSArray *keys = [_list.cache allKeys];
        NSString* aKey = [keys objectAtIndex:[indexPath row]];
        anObject = [_list.cache objectForKey:aKey];
        cell.textLabel.text = anObject.title;
    
    }
    
    
  
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Anime *anObject;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        
        NSArray *keys = [_results allKeys];
        NSString* aKey = [keys objectAtIndex:[indexPath row]];
        anObject = [_results objectForKey:aKey];
        VideoInformation *info = [VideoInformation singleton];
        [info setInstance:anObject];
    }
    else{
        NSArray *keys = [_list.cache allKeys];
        NSString* aKey = [keys objectAtIndex:[indexPath row]];
        anObject = [_list.cache objectForKey:aKey];
        VideoInformation *info = [VideoInformation singleton];
        [info setInstance:anObject];
    }
    
    
    NSLog(@"selected %@",anObject.title);
}

-(void) filterContentsForSearchText:(NSString *) searchText scope:(NSString *)scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:[_list.cache allValues] ];
    NSMutableArray *tmpNames = [[NSMutableArray alloc] initWithArray:[_list.cache allKeys]];
    NSArray *cacheResults = [tmpNames filteredArrayUsingPredicate:predicate];
    for(int i =0; i < [cacheResults count]; i++){
        Anime *toLoad = [tmpArray objectAtIndex:i];
       // NSLog(@"name %@",toLoad.title);
        _results[toLoad.title] = toLoad;
        
    }
}

-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentsForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex] ]];
    

    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    _list = [AnimeCache singleton];
    [_list loadTitles];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
