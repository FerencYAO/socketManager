//
//  SocketManager.m
//  SocketClient
//
//  Created by Mac03 on 15/4/1.
//  Copyright (c) 2015年 simple. All rights reserved.
//

#import "SocketManager.h"
#import "AsyncUdpSocket.h"

static SocketManager *socketManger;

@interface SocketManager () <AsyncUdpSocketDelegate>

@end

@implementation SocketManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketManger = [[SocketManager alloc] init];
    });
    return socketManger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    }
    return self;
}

- (void)connectToHost:(NSString *)host onPort:(UInt16)port
{
    [self.udpSocket connectToHost:host onPort:port error:nil];
}

- (void)sendData:(NSData *)data
{
    [self.udpSocket sendData:data withTimeout:3 tag:0];
}

- (void)close
{
    [self.udpSocket closeAfterSendingAndReceiving];
}

#pragma mark - AsyncUdpSocketDelegate

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(receiveData:)]) {
        [self.delegate receiveData:data];
    }
    return YES;
}

@end
