//
//  ViewController.m
//  WebConnection
//
//  Created by Prasanna on 12/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

#import "ViewController.h"
#import "WebClass.h"

@interface ViewController ()<WebClassDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([WebClass isNetworkAvailable]) {
        [SVProgressHUD show];
        WebClass *communicationHandler=[[WebClass alloc]init];
        [communicationHandler requestWithUrl:@"https://itunes.apple.com/in/rss/newapplications/limit=100/json" WithParameters:nil WithRequestMethod:@"GET" WithNetWorkHandler:self WithRelatedContext:@"ITUNES"];
    }
    
}

-(void)delegateCommunicationHandler:(WebClass *)handlerClass WithDownloadDidCompleteWithResponse:(NSURLResponse *)serverResponce WithError:(NSError *)error WithResponceObject:(id)responceObject WithRelatedContext:(NSString *)context
{
    [SVProgressHUD dismiss];
    NSLog(@"Reply JSON: %@", responceObject);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
