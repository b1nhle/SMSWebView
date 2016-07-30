//
//  ViewController.m
//  SMSWebview
//
//  Created by Binh Le on 7/30/16.
//  Copyright © 2016 BL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIActionSheetDelegate>

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
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"test_sms%@",version] ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

- (IBAction)fireAction:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"CHOOSE VERSION" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Version: &",
                            @"Version: ;",
                            nil];
    [popup showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self loadHTMLWith:0];
            break;
        case 1:
            [self loadHTMLWith:1];
            break;
        default:
            break;
    }
}

@end
