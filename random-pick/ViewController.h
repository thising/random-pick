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
@property IBOutlet NSTextView *tvNames;
@property IBOutlet NSButton *btnSave;
@property IBOutlet NSTextField *record;

@property BOOL start;
@property NSMutableArray *names;
@property NSTimer *timer;
@property NSSound *startSound;
@property NSSound *endSound;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)importMenuAction:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

- (void)timerProcesser;

@end

