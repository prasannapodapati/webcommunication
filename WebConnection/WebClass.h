//
//  WebClass.h
//  WebConnection
//
//  Created by Prasanna on 13/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Reachability.h"
#import "SVProgressHUD/SVProgressHUD.h"

@protocol WebClassDelegate;

@interface WebClass : NSObject<NSURLSessionDelegate>

+ (BOOL)isNetworkAvailable;
@property (weak , nonatomic) id<WebClassDelegate> webDelegate;
-(void)requestWithUrl:(NSString *)requestUrl WithParameters:(id)params WithRequestMethod:(NSString *)requestMethod WithNetWorkHandler:(id<WebClassDelegate>)delegate WithRelatedContext:(NSString *)context;

@end

@protocol WebClassDelegate <NSObject>

-(void)delegateCommunicationHandler:(WebClass *)handlerClass WithDownloadDidCompleteWithResponse:(NSURLResponse *)serverResponce WithError:(NSError *)error WithResponceObject:(id)responceObject WithRelatedContext:(NSString *)context;

@end
