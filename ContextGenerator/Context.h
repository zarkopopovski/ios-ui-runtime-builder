//
//  Context.h
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 19/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "ParsedElement.h"

@interface Context : NSObject {
    UIView *parentView_;
    NSString *xmlContext_;
    NSMutableArray *contextObjects_;
    TBXML *tbXMLParser_;
}

@property(nonatomic, retain) UIView *parentView;
@property(nonatomic, assign) NSString *xmlContext;
@property(nonatomic, retain) NSMutableArray *contextObjects;
@property(nonatomic, retain) TBXML *tbXMLParser;

- (id)initWithXML:(NSString *)xmlContext parentView:(UIView *)parentView;
- (void)parseXMLContextToObjects:(TBXMLElement *)element parsedObject:(ParsedElement *)parsedObject hasElements:(BOOL)hasElements;	
- (UIView *)findViewById:(NSString *)viewId;
- (UIView *)findViewById:(NSString *)viewId childArray:(NSMutableArray *)childArray;
- (id)createObjectWithID:(NSString *)stringType;
- (void)setAttributesToParsedElement:(ParsedElement *)parsedObject;

- (void)setUIButtonAttributes:(ParsedElement *)parsedObject;
- (void)setUILabelAttributes:(ParsedElement *)parsedObject;
- (void)setUITextFieldAttributes:(ParsedElement *)parsedObject;
- (void)setUITextViewAttributes:(ParsedElement *)parsedObject;
- (void)setUIImageViewAttributes:(ParsedElement *)parsedObject;
- (void)setUIToolbarAttributes:(ParsedElement *)parsedObject;
- (void)setUIBarButtonItemAttributes:(ParsedElement *)parsedObject;

- (void)setUIButtonTitleWithStates:(ParsedElement *)parsedObject title:(NSString *)title state:(NSString *)state;
- (void)setUIButtonImageWithStates:(ParsedElement *)parsedObject image:(NSString *)image state:(NSString *)state;
- (void)setUIButtonBackgroundImageWithStates:(ParsedElement *)parsedObject image:(NSString *)image state:(NSString *)state;

- (CGRect)generateCGRect:(NSArray *)attrArray;
- (CGFloat)transformValue:(NSString *)value;
- (UITextAlignment)getAllignment:(NSString *)allignmentValue;  
- (UITextBorderStyle)getBorderStyle:(NSString *)borderStyleValue;
- (UIBarStyle)getBarStyle:(NSString *)barStyleValue;

- (UIBarButtonItemStyle)getBarButtonItemStyle:(NSString *)barButtonItemStyle;
- (UIBarButtonSystemItem)getBarButtonSystemItem:(NSString *)barButtonSystemItemType;
- (NSArray *)setBarButtonItemsToParent:(ParsedElement *)parsedObject;
- (void)ifToolbarExistWithBarButtonItemsThenMakeConnection:(NSMutableArray *)parsedObjects;

- (UIView *)generateCustomBarButtonItemByType:(NSString *)viewType;

- (void)setupUIelements;
- (void)setupUIelementsForView:(ParsedElement *)parentElement childElement:(ParsedElement *)childElement;

@end
