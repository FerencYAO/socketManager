//
//  SocketManager.h
//  SocketClient
//
//  Created by Mac03 on 15/4/1.
//  Copyright (c) 2015年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncUdpSocket;
@protocol SocketManagerDelegate;

@interface SocketManager : NSObject

@property (strong, nonatomic) AsyncUdpSocket *udpSocket;
@property (assign, nonatomic) id<SocketManagerDelegate> delegate;

+ (instancetype)shareInstance;

/* 连接 */
- (void)connectToHost:(NSString *)host onPort:(UInt16)port;
/* 发消息 */
- (void)sendData:(NSData *)data;
/* 关闭连接 */
- (void)close;

@end

@protocol SocketManagerDelegate <NSObject>

- (void)receiveData:(NSData *)data;

@end
