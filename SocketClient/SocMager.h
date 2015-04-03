//
//  SocMager.h
//  SocMager
//
//  Created by Mac03 on 15/4/3.
//  Copyright (c) 2015年 cn.edu.cqut.cs.c102. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncUdpSocket;
@protocol SocketManagerDelegate;

@interface SocMager : NSObject

@property (strong, nonatomic) AsyncUdpSocket *udpSocket;
@property (assign, nonatomic) id<SocketManagerDelegate> delegate;

+ (instancetype)shareInstance;

/* 连接并设置代理，host(服务器ip地址),port（端口号）,aDelegate（代理）都不能为空。 */
- (void)connectToHost:(NSString *)host onPort:(UInt16)port delegate:(id<SocketManagerDelegate>)aDelegate;
/* 发消息 */
- (void)sendData:(NSData *)data;
/* 关闭连接 */
- (void)close;

@end

@protocol SocketManagerDelegate <NSObject>

/* 收到消息之后的回调 */
- (void)receiveData:(NSData *)data;

@end
