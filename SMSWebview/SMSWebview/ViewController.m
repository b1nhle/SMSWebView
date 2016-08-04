//
//  ViewController.m
//  SMSWebview
//
//  Created by Binh Le on 7/30/16.
//  Copyright © 2016 BL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIActionSheetDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadHTMLWith:(int)index {
    NSString *version = @"_and";
    if (index == 1) {
        version = @"_semi_colon";
    }
    if (index == 2) {
        version = @"_semi_colon_no_contact";
    }
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"test_sms%@",version] ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

- (IBAction)fireAction:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"CHOOSE VERSION" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"iOS 8+9 &",
                            @"iOS 7 ; IN CONTACT",
                            @"iOS 7 ; NOT IN CONTACT",
                            nil];
    [popup showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        case 1:
        case 2:
            [self loadHTMLWith:(int)buttonIndex];
            break;
        default:
            break;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.absoluteString rangeOfString:@"sms:"].location != NSNotFound) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:request.URL.absoluteString]];
        return NO;
    }
    return YES;
}

@end
