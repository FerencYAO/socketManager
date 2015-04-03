//
//  ViewController.m
//  SocketClient
//
//  Created by Simple on 13-4-2.
//  Copyright (c) 2013年 simple. All rights reserved.
//

#import "ViewController.h"
#import "SocMager.h"

@interface ViewController () <SocketManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _SendMessage.delegate=self;
    [_SendMessage setTag:2];
    [[SocMager shareInstance] connectToHost:@"192.168.1.26" onPort:34567 delegate:self];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [[SocMager shareInstance] close];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Send:(id)sender {
    NSLog(@"-----sendMessage----text----%@----", _SendMessage.text);
    if(![_SendMessage.text isEqualToString:@""])
    {
        NSLog(@"----sendData----%@-----", _SendMessage.text);
        NSData *sendData = [_SendMessage.text dataUsingEncoding:NSUTF8StringEncoding];
        [[SocMager shareInstance] sendData:sendData];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Waring" message:@"Please input Message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - SocketManagerDelegate

- (void)receiveData:(NSData *)data
{
    NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"----receiveStr----%@-----", receiveStr);
}

#pragma end Delegate
- (void)dealloc {
    [_SendMessage release];
    [super dealloc];
}

@end
