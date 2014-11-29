//
//  FirstUIViewController.m
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstUIViewController.h"


@implementation FirstUIViewController

@synthesize btnTest = _btnTest;
@synthesize btnTest2 = _btnTest2;
@synthesize testLab = _testLab;
@synthesize testTextField = _testTextField;
//@synthesize testTextView = _testTextView;
@synthesize testImageView = _testImageView;
@synthesize testToolBar = _testToolBar;

@synthesize context = context_;

- (void)actionTest:(id)sender{
    NSLog(@"Hi from builded button");
}

- (void)initView{
    self.context = [[Context alloc] initWithXML:@"uitest.xml" parentView:self.view];

    self.btnTest = (UIButton *)[self.context findViewById:@"testbtn"];
    self.btnTest2 = (UIButton *)[self.context findViewById:@"testbtn2"];
    self.testLab = (UILabel*)[self.context findViewById:@"testlabel"];
    self.testTextField = (UITextField *)[self.context findViewById:@"testtextfield"];
    //self.testTextView = (UITextView *)[self.context findViewById:@"testtextview"];
    self.testImageView = (UIImageView *)[self.context findViewById:@"imgview"];
    self.testToolBar = (UIToolbar *)[self.context findViewById:@"rootbar"];
    
    //[self.context setupUIelements];
    [self.view addSubview:self.btnTest];
    [self.view addSubview:self.btnTest2];
    [self.view addSubview:self.testLab];
    [self.view addSubview:self.testTextField];
    //[self.view addSubview:self.testTextView];
    [self.view addSubview:self.testToolBar];
        
    [self.view addSubview:self.testImageView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initView];        
    }
    return self;
}

- (void)dealloc
{   
    [self.context release];
    
    [self.btnTest release];
    [self.btnTest2 release];
    [self.testLab release];
    [self.testTextField release];
    //[self.testTextView release];
    [self.testToolBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
