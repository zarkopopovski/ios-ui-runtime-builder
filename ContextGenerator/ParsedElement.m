//
//  ParsedElement.m
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 20/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParsedElement.h"


@implementation ParsedElement

@synthesize type = type_;
@synthesize viewId = viewId_;
@synthesize instance = instance_;
@synthesize attributesDict = attributesDict_;
@synthesize parsedChildElements = parsedChildElements_;

- (id)init{
    if(!(self = [super init])){
        return nil;
    }
    return self;
}

- (void)dealloc{
    [self.type release];
    [self.viewId release];
    [self.instance release];
    [self.attributesDict release];
    [self.parsedChildElements release];
    [super dealloc];
}

@end
