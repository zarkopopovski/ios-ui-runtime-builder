//
//  FirstUIViewController.h
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Context.h"


@interface FirstUIViewController : UIViewController {
    UIButton *_btnTest;
    UIButton *_btnTest2;
    UILabel *_testLab;
    UITextField *_testTextField;
    //UITextView *_testTextView;
    UIImageView *_testImageView;
    UIToolbar *_testToolBar;
    
    Context *context_;
}
@property(nonatomic, retain) UIButton *btnTest;
@property(nonatomic, retain) UIButton *btnTest2;
@property(nonatomic, retain) UILabel *testLab;
@property(nonatomic, retain) UITextField *testTextField;
//@property(nonatomic, retain) UITextView *testTextView;
@property(nonatomic,retain) UIImageView *testImageView;
@property(nonatomic, retain) UIToolbar *testToolBar;

@property(nonatomic, retain) Context *context;

- (void)actionTest:(id)sender;
- (void)initView;

@end
