//
//  TitleViewController.h
//  VideoStreaming
//
//  Created by Diego on 3/30/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "ViewController.h"

@interface TitleViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) NSMutableArray *arr;

@property(nonatomic) IBOutlet UIImageView* poster;
@property (nonatomic) IBOutlet UILabel *titleAnime;
@property(nonatomic) IBOutlet UITextView * summ;
@property(nonatomic) Anime* local;
@property(nonatomic) NSMutableDictionary *dict;
//@property (nonatomic) IBOutlet UILabel *summary;





@property(nonatomic,strong) IBOutlet UITextView* text ;
@end
