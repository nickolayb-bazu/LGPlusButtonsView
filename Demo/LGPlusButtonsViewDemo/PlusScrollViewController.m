//
//  PlusScrollViewController.m
//  LGPlusButtonsViewDemo
//
//  Created by Grigory Lutkov on 26.02.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "PlusScrollViewController.h"
#import "LGPlusButtonsView.h"

@interface PlusScrollViewController ()

@property (strong, nonatomic) UIScrollView      *scrollView;
@property (strong, nonatomic) UIView            *exampleView;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewNavBar;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewExample;

@end

@implementation PlusScrollViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGPlusButtonsView";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showHideButtonsAction)];

        // -----

        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];

        _exampleView = [UIView new];
        _exampleView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.1];
        [_scrollView addSubview:_exampleView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];



    // -----

    
    NSMutableArray *buttonTitles = [NSMutableArray arrayWithArray:@[@"M", @"J", @"E", @"V"]];
    NSMutableArray *buttonDescriptions = [NSMutableArray arrayWithArray:@[@"Member", @"Join", @"Event", @"Visit"]];
    
    _plusButtonsViewExample = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:4
                                                         firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES
                                                                   actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                            }];

    _plusButtonsViewExample.position = LGPlusButtonsViewPositionBottomLeft;
    _plusButtonsViewExample.openingSide = LGPlusButtonsViewOpeningSideRight;
    _plusButtonsViewExample.plusButtonAnimationType = LGPlusButtonAnimationTypeCrossDissolve;
    _plusButtonsViewExample.buttonsAppearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolve;
    _plusButtonsViewExample.descriptionsPosition = LGPlusButtonDescriptionsPositionBottom;
    
//    [_plusButtonsViewExample setButtonsInsets:UIEdgeInsetsMake(0, 0, 0, 34) forOrientation:LGPlusButtonsViewOrientationAll];
    
    
    [_plusButtonsViewExample setButtonsTitles:buttonTitles forState:UIControlStateNormal];
    [_plusButtonsViewExample setDescriptionsTexts:buttonDescriptions];

    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.f blue:0.5 alpha:1.f] forState:UIControlStateNormal];
    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.2 blue:0.6 alpha:1.f] forState:UIControlStateHighlighted];
    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.2 blue:0.6 alpha:1.f] forState:UIControlStateHighlighted|UIControlStateSelected];
    [_plusButtonsViewExample setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setButtonsLayerBorderWidth:2.f];
    [_plusButtonsViewExample setButtonsLayerBorderColor:[UIColor colorWithWhite:0.9 alpha:1.f]];
    [_plusButtonsViewExample setButtonsTitleFont:[UIFont systemFontOfSize:24.f] forOrientation:LGPlusButtonsViewOrientationAll];
    

    for (int i = 1; i < [buttonDescriptions count]; i++) {
        [_plusButtonsViewExample setButtonAtIndex:i offset:CGPointMake(17, 0) forOrientation:LGPlusButtonsViewOrientationAll];
        [_plusButtonsViewExample setDescriptionAtIndex:i offset:CGPointMake(17, 0) forOrientation:LGPlusButtonsViewOrientationAll];
    }
    
    [_plusButtonsViewExample setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -2.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setButtonAtIndex:0 title:@"-" forState:UIControlStateSelected];

    [_plusButtonsViewExample setDescriptionsTextColor:[UIColor whiteColor]];
    [_plusButtonsViewExample setDescriptionsFont:[UIFont boldSystemFontOfSize:12.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setDescriptionsInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, 4.f) forOrientation:LGPlusButtonsViewOrientationAll];

    [_exampleView addSubview:_plusButtonsViewExample];
}

#pragma mark - Dealloc

- (void)dealloc
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

#pragma mark - Appearing

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    _scrollView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);

    UIEdgeInsets contentInsets = _scrollView.contentInset;
    contentInsets.top = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 2000.f);

    // -----

    _exampleView.frame = CGRectMake(0.f, 0.f, _scrollView.frame.size.width, 400.f);
}

#pragma mark -

- (void)showHideButtonsAction
{
    if (_plusButtonsViewNavBar.isShowing)
        [_plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
    else
        [_plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
}


@end
