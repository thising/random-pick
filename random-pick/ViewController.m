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
    _names = [NSMutableArray new];
    _btnSave.hidden = YES;
    _tvNames.hidden = YES;
    _startSound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"start" ofType:@"mp3"] byReference:NO];
    _startSound.loops = YES;
    _endSound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stop" ofType:@"mp3"] byReference:NO];
}

- (void)viewDidLayout {
    [super viewDidLayout];
    NSRect frame = NSMakeRect(self.view.frame.size.width * 775.0 / 960.0, self.view.frame.size.height * 99.0 / 540.0, _button.frame.size.width, _button.frame.size.height);
    _button.frame = frame;
    frame = NSMakeRect(self.view.frame.size.width * 624.0 / 960.0, self.view.frame.size.height * 282.0 / 540.0, _name.frame.size.width, _name.frame.size.height);
    _name.frame = frame;
    _name.font = [NSFont boldSystemFontOfSize:MIN(self.view.frame.size.width * 70.0 / 960.0, 150.0)];
    
    frame = NSMakeRect(self.view.frame.size.width * 634.0 / 960.0, self.view.frame.size.height * 149.0 / 540.0, _record.frame.size.width, _record.frame.size.height);
    _record.frame = frame;
    _record.font = [NSFont boldSystemFontOfSize:MIN(self.view.frame.size.width * 15.0 / 960.0, 30.0)];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)buttonPressed:(id)sender
{
    if ([_names count] < 2)
    {
        NSAlert *alert = [NSAlert new];
        [alert addButtonWithTitle:@"确定"];
        [alert setMessageText:@"请核对抽奖人员名单"];
        [alert setInformativeText:@"名单数量过少，请导入名单后进行抽奖！"];
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:[self.view window] completionHandler:nil];
        [self importMenuAction:nil];
    }
    else
    {
        _start = !_start;
        
        [_button setImage:(_start ? [NSImage imageNamed:@"stop"] : [NSImage imageNamed:@"start"])];
        
        if (_start) {
            [_startSound play];
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerProcesser) userInfo:nil repeats:YES];
        } else {
            [_timer invalidate];
            [_startSound stop];
            [_endSound play];
            if (_record.stringValue.length == 0)
            {
                _record.stringValue = [NSString stringWithFormat:@"获奖人员名单：\n%@", _name.stringValue];
            }
            else
            {
                _record.stringValue = [NSString stringWithFormat:@"%@、%@", _record.stringValue, _name.stringValue];
            }
            
            [_names removeObject:_name.stringValue];
        }
    }
}

- (IBAction)importMenuAction:(id)sender
{
    _btnSave.hidden = NO;
    _tvNames.hidden = NO;
}

- (IBAction)saveButtonPressed:(id)sender
{
    _btnSave.hidden = YES;
    _tvNames.hidden = YES;
    
    NSString *buf = _tvNames.string;
    NSArray *list = [buf componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    [_names removeAllObjects];
    
    for (NSString *item in list)
    {
        NSString *tmp = [item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([tmp length] > 0)
        {
            [_names addObject:tmp];
        }
    }
    
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:@"请核对人员数量是否一致"];
    [alert setInformativeText:[NSString stringWithFormat:@"当前自动识别到共有 %lu 名贵宾参与抽奖", [_names count]]];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[self.view window] completionHandler:nil];
}

- (void)timerProcesser
{
    int indx = arc4random_uniform([_names count]);
    [_name setStringValue:[_names objectAtIndex:indx]];
}


@end
