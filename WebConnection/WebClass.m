//
//  WebClass.m
//  WebConnection
//
//  Created by Prasanna on 13/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

#import "WebClass.h"

@implementation WebClass
+ (BOOL)isNetworkAvailable
{
    AppDelegate *appDelegate=((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    Reachability *internetReachabilityTest = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [internetReachabilityTest currentReachabilityStatus];
    
    if (networkStatus == NotReachable) /* NETWORK Reachability*/
    {
        [appDelegate showAlertViewWithMessage:@"Network is not Reachable, Please try again" WithTitle:@"QLIMO" cancelButton:@"OK"];
        
        return NO;
    }
    else
    {
        Reachability *internetReachableFoo = [Reachability reachabilityWithHostName:@"www.apple.com"];
        
        if (internetReachableFoo) {
            
            return YES;
        }
        else
        {
            [appDelegate showAlertViewWithMessage:@"Internet is available but Network Traffic, Please try again" WithTitle:@"QLIMO" cancelButton:@"OK"];
            
            return NO;
        }
    }
    
    return YES;
}

- (void)requestWithUrl:(NSString *)requestUrl WithParameters:(id)params WithRequestMethod:(NSString *)requestMethod WithNetWorkHandler:(id<WebClassDelegate>)delegate WithRelatedContext:(NSString *)context
{
    
    self.webDelegate = delegate;
    context = context;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURL *URL = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:requestMethod];
    NSError *error;
    if (params) {
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        [request setHTTPBody:postData];
    }
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id responseObject;
        if (data)
            responseObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        
        if (!error) {
            
            if (([responseObject isKindOfClass:[NSDictionary class]])||([responseObject isKindOfClass:[NSArray class]])) {
                [self.webDelegate delegateCommunicationHandler:self WithDownloadDidCompleteWithResponse:response WithError:nil WithResponceObject:responseObject WithRelatedContext:context];
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            @try {
                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                
                if (statusCode != 200) {
                    NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                    [SVProgressHUD dismiss];
                    
                    return;
                }
            } @catch (NSException *exception) {
                NSLog(@"error at api response error");
                [SVProgressHUD dismiss];
                
            } @finally {
                [SVProgressHUD dismiss];
                [self.webDelegate delegateCommunicationHandler:self WithDownloadDidCompleteWithResponse:response WithError:nil WithResponceObject:responseObject WithRelatedContext:context];
                
            }
        }
        
    }];
    
    [dataTask resume];
}

@end
