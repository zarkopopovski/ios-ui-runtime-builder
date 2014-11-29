//
//  ParsedElement.h
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 20/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsedElement : NSObject {
    NSString *type_;
    NSString *viewId_;
    UIView *instance_;
    NSMutableDictionary *attributesDict_;
    NSMutableArray *parsedChildElements_;
}

@property(nonatomic, assign) NSString *type;
@property(nonatomic, assign) NSString *viewId;
@property(nonatomic, retain) UIView *instance;
@property(nonatomic, retain) NSMutableDictionary *attributesDict; // Attributes
@property(nonatomic, retain) NSMutableArray *parsedChildElements; // Child elements

@end
