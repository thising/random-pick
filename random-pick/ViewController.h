//
//  ViewController.h
//  random-pick
//
//  Created by Kyle Davis on 2019/8/21.
//  Copyright © 2019 Kyle Davis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property IBOutlet NSButton *button;
@property IBOutlet NSTextField *name;
@property BOOL start;
@property NSArray *names;
@property NSTimer *timer;

- (IBAction)buttonPressed:(id)sender;
- (void)timerProcesser;

@end

