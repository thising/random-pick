//
//  ViewController.m
//  random-pick
//
//  Created by Kyle Davis on 2019/8/21.
//  Copyright © 2019 Kyle Davis. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _names = [[NSArray alloc] initWithObjects:@"张三", @"李四", @"王杰", nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)buttonPressed:(id)sender
{
    _start = !_start;
    
    [_button setTitle:(_start ? @"停止" : @"开始")];
    
    if (_start) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerProcesser) userInfo:nil repeats:YES];
    } else {
        [_timer invalidate];
    }
    
}

- (void)timerProcesser
{
    int indx = arc4random_uniform([_names count]);
    [_name setStringValue:[_names objectAtIndex:indx]];
}


@end
