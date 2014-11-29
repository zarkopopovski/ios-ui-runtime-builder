//
//  Context.m
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 19/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Context.h"
#import "ParsedElement.h"
#import <QuartzCore/QuartzCore.h>

#define ELEMENT_ID @"id"
#define ELEMENT_XPOS @"posX"
#define ELEMENT_YPOS @"posY"
#define ELEMENT_WIDTH @"width"
#define ELEMENT_HEIGHT @"height"
#define ELEMENT_TYPE @"type"
#define ELEMENT_TITLE_FOR_STATE @"titleForState"
#define ELEMENT_ROUNDED @"rounded"
#define ELEMENT_TRANSFORM @"transform"
#define ELEMENT_CORNER_RADIUS @"cornerRadius"
#define ELEMENT_IMAGE_FOR_STATE @"imageForState"
#define ELEMENT_BACKGROUND_IMAGE_FOR_STATE @"backgroundImageForState"
#define ELEMENT_CLEAR_COLOR @"clearColor"
#define ELEMENT_TEXT @"text"
#define ELEMENT_TEXT_ALLIGNMENT @"textAllignment"
#define ELEMENT_BORDER_STYLE @"borderStyle"
#define ELEMENT_BACKGROUND @"background"
#define ELEMENT_DISABLED_BACKGROUND @"disabledBackground"
#define ELEMENT_EDITABLE @"editable"
#define ELEMENT_IMAGE_SOURCE @"imageSrc"
#define ELEMENT_BAR_STYLE @"barStyle"
#define ELEMENT_INIT_TYPE @"initType"
#define ELEMENT_INIT_SYSTEM_TYPE @"itemSystemType"
#define ELEMENT_ACTION_TARGET @"actionTarget"
#define ELEMENT_VIEW_TYPE @"viewType"
#define ELEMENT_BUTTON_STYLE @"buttonStyle"
#define ELEMENT_TITLE @"title"


@implementation Context

@synthesize parentView = parentView_;
@synthesize xmlContext = xmlContext_;
@synthesize contextObjects = contextObjects_;
@synthesize tbXMLParser = tbXMLParser_;

- (id)init{
    if (!(self = [super init])) {
       return nil;
    } 
    return self;
}

- (id)initWithXML:(NSString *)xmlContext parentView:(UIView *)parentView{
    self = [super init];
    if (self) {        
        self.parentView = parentView;
        self.xmlContext = xmlContext;
        self.tbXMLParser = [[TBXML alloc] initWithXMLFile:self.xmlContext];
        self.contextObjects = [[NSMutableArray alloc] init];
        [self parseXMLContextToObjects:self.tbXMLParser.rootXMLElement parsedObject:nil hasElements:NO];
        [self ifToolbarExistWithBarButtonItemsThenMakeConnection:self.contextObjects];
        //[self setupUIelements];
    } 

    return self;    
}

- (id)createObjectWithID:(NSString *)stringType{   
    if ([stringType isEqualToString:@"UIButton"]) {
        return [[UIButton alloc] init];             
    } else if ([stringType isEqualToString:@"UILabel"]) {
        return [[UILabel alloc] init];           
    } else if ([stringType isEqualToString:@"UITextField"]) {
        return [[UITextField alloc] init];           
    } else if ([stringType isEqualToString:@"UITextView"]) {
        return [[UITextView alloc] init];           
    } else if ([stringType isEqualToString:@"UIImageView"]) {
        return [[UIImageView alloc] init];           
    } else if ([stringType isEqualToString:@"UIToolbar"]) {
        return [[UIToolbar alloc] init];           
    } 
}
- (void)setAttributesToParsedElement:(ParsedElement *)parsedObject{
    if ([parsedObject.type isEqualToString:@"UIButton"]) {
        [self setUIButtonAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UILabel"]) {
        [self setUILabelAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UITextField"]) {
        [self setUITextFieldAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UITextView"]) {
        [self setUITextViewAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UIImageView"]) {
        [self setUIImageViewAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UIToolbar"]) {
        [self setUIToolbarAttributes:parsedObject];
    } else if ([parsedObject.type isEqualToString:@"UIBarButton"]) {
        [self setUIBarButtonItemAttributes:parsedObject];
    }  
    
}

- (void)setUIButtonAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementType = nil;
    NSString *titleForState = nil;
    NSString *isRounded = nil;    
    NSNumber *cornerRadius = nil;
    NSString *imageForState = nil;
    NSString *backgroundImageForState = nil;
    NSString *elementTransform = nil;

    NSArray *rangeOfTitleStates = nil;
    NSArray *rangeOfImagesStates = nil;
    NSArray *rangeOfBackgroundImagesStates = nil;
        
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TYPE] && elementType == nil) {
            elementType = [[NSString alloc] initWithString:[attributesProperties valueForKey:key]];            
        } else if ([key isEqualToString:ELEMENT_TITLE_FOR_STATE] && titleForState == nil) {
            titleForState = [[NSString alloc] initWithString:[attributesProperties valueForKey:key]];            
        } else if ([key isEqualToString:ELEMENT_ROUNDED] && isRounded == nil) {
            isRounded = [[NSString alloc] initWithString:[attributesProperties valueForKey:key]];            
        } else if ([key isEqualToString:ELEMENT_CORNER_RADIUS] && cornerRadius == nil) {
            cornerRadius = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_IMAGE_FOR_STATE] && imageForState == nil) {
            imageForState = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_BACKGROUND_IMAGE_FOR_STATE] && backgroundImageForState == nil) {
            backgroundImageForState = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TRANSFORM] && elementTransform == nil) {
            elementTransform = [attributesProperties valueForKey:key];            
        } 
    }
    
    if (emID) {
        parsedObject.viewId = emID;
    }
 
    if ([elementType isEqualToString:@"Custom"]) {
        parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
        //instancedButton = (UIButton *)parsedObject.instance;
        
        if (isRounded != nil && [isRounded isEqualToString:@"YES"]) {
            if (cornerRadius != nil) {
                ((UIButton *)parsedObject.instance).layer.cornerRadius = [cornerRadius floatValue];
            }
        }
        
    } else if ([elementType isEqualToString:@"RoundedRect"]) {
        parsedObject.instance = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    } else {
        [self createObjectWithID:parsedObject.type];
        parsedObject.instance = (UIButton *)parsedObject.instance;
    }
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UIButton *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 
    
    if ([titleForState rangeOfString:@"|"].location != NSNotFound) {
        rangeOfTitleStates = [titleForState componentsSeparatedByString:@"|"];
        
        for (int i = 0; i < [rangeOfTitleStates count]; i++) {
            
            NSArray *titleStateElements = [[rangeOfTitleStates objectAtIndex:i] componentsSeparatedByString:@"~"];          
            [self setUIButtonTitleWithStates:parsedObject title:[[titleStateElements objectAtIndex:1] substringFromIndex:1] state:[titleStateElements objectAtIndex:0]];            
        }        
        
    } else {
        NSArray *titleStateElements = [titleForState componentsSeparatedByString:@"~"];
        [self setUIButtonTitleWithStates:parsedObject title:[[titleStateElements objectAtIndex:1] substringFromIndex:1] state:[titleStateElements objectAtIndex:0]];
    }
    
    if ([imageForState rangeOfString:@"|"].location != NSNotFound) {
        rangeOfImagesStates = [imageForState componentsSeparatedByString:@"|"];
        for (int i = 0; i < [rangeOfImagesStates count]; i++) {
            
            NSArray *imageForStateElements = [[rangeOfImagesStates objectAtIndex:i] componentsSeparatedByString:@"~"]; 
            [self setUIButtonImageWithStates:parsedObject image:[imageForStateElements objectAtIndex:1] state:[imageForStateElements objectAtIndex:0]];            
        }  
        
        
    } else {
        NSArray *imageForStateElements = [imageForState componentsSeparatedByString:@"~"];       
        
        [self setUIButtonImageWithStates:parsedObject image:[imageForStateElements objectAtIndex:1] state:[imageForStateElements objectAtIndex:0]]; 
    }
    
    if ([backgroundImageForState rangeOfString:@"|"].location != NSNotFound) {
        rangeOfBackgroundImagesStates = [backgroundImageForState componentsSeparatedByString:@"|"];
        for (int i = 0; i < [rangeOfBackgroundImagesStates count]; i++) {
            
            NSArray *backgroundImageForStateElements = [[rangeOfBackgroundImagesStates objectAtIndex:i] componentsSeparatedByString:@"~"]; 
            [self setUIButtonImageWithStates:parsedObject image:[backgroundImageForStateElements objectAtIndex:1] state:[backgroundImageForStateElements objectAtIndex:0]];            
        }  
        
        
    } else {
        NSArray *backgroundImageForStateElements = [backgroundImageForState componentsSeparatedByString:@"~"]; 
        
        [self setUIButtonImageWithStates:parsedObject image:[backgroundImageForStateElements objectAtIndex:1] state:[backgroundImageForStateElements objectAtIndex:0]];   
    }
    
    if (elementTransform != nil) {
        ((UIButton *)parsedObject.instance).transform = CGAffineTransformMakeRotation([self transformValue:elementTransform]);
    }    
            
}

- (void)setUIButtonTitleWithStates:(ParsedElement *)parsedObject title:(NSString *)title state:(NSString *)state{
    if ([state isEqualToString:@"Normal"]) {
        [(UIButton *)parsedObject.instance setTitle:title forState:UIControlStateNormal];
    } else if ([state isEqualToString:@"Highlated"]) {
        [(UIButton *)parsedObject.instance setTitle:title forState:UIControlStateHighlighted];
    } else if ([state isEqualToString:@"Selected"]) {
        [(UIButton *)parsedObject.instance setTitle:title forState:UIControlStateSelected];
    } else if ([state isEqualToString:@"Disabled"]) {
        [(UIButton *)parsedObject.instance setTitle:title forState:UIControlStateDisabled];
    }
}

- (void)setUIButtonImageWithStates:(ParsedElement *)parsedObject image:(NSString *)image state:(NSString *)state{
    if ([state isEqualToString:@"Normal"]) {
        [(UIButton *)parsedObject.instance setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    } else if ([state isEqualToString:@"Highlated"]) {
        [(UIButton *)parsedObject.instance setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];       
    } else if ([state isEqualToString:@"Selected"]) {
        [(UIButton *)parsedObject.instance setImage:[UIImage imageNamed:image] forState:UIControlStateSelected]; 
    } else if ([state isEqualToString:@"Disabled"]) {
        [(UIButton *)parsedObject.instance setImage:[UIImage imageNamed:image] forState:UIControlStateDisabled]; 
    } 
}

- (void)setUIButtonBackgroundImageWithStates:(ParsedElement *)parsedObject image:(NSString *)image state:(NSString *)state{
    if ([state isEqualToString:@"Normal"]) {
        [(UIButton *)parsedObject.instance setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    } else if ([state isEqualToString:@"Highlated"]) {
        [(UIButton *)parsedObject.instance setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];       
    } else if ([state isEqualToString:@"Selected"]) {
        [(UIButton *)parsedObject.instance setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateSelected]; 
    } else if ([state isEqualToString:@"Disabled"]) {
        [(UIButton *)parsedObject.instance setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateDisabled]; 
    } 
}

- (CGFloat)transformValue:(NSString *)value{
    if ([value isEqualToString:@"M_E"]) {
        return M_E;
    } else if ([value isEqualToString:@"M_LOG2E"]) {
        return M_LOG2E;
    } else if ([value isEqualToString:@"M_LOG10E"]) {
        return M_LOG10E;
    } else if ([value isEqualToString:@"M_LN2"]) {
        return M_LN2;
    } else if ([value isEqualToString:@"M_LN10"]) {
        return M_LN10;
    } else if ([value isEqualToString:@"M_PI"]) {
        return M_PI;
    } else if ([value isEqualToString:@"M_PI_2"]) {
        return M_PI_2;
    } else if ([value isEqualToString:@"M_PI_4"]) {
        return M_PI_4;
    } else if ([value isEqualToString:@"M_1_PI"]) {
        return M_1_PI;
    } else if ([value isEqualToString:@"M_2_PI"]) {
        return M_2_PI;
    } else if ([value isEqualToString:@"M_2_SQRTPI"]) {
        return M_2_SQRTPI;
    } else if ([value isEqualToString:@"M_SQRT2"]) {
        return M_SQRT2;
    } else if ([value isEqualToString:@"M_SQRT1_2"]) {
        return M_SQRT1_2;
    } else {
        return 0;
    } 
}

- (void)setUILabelAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementText = nil;
    NSString *elementAllign = nil;
    NSString *elementTransform = nil;
    NSString *elementClearColor = nil;
    
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TRANSFORM] && elementTransform == nil) {
            elementTransform = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_CLEAR_COLOR] && elementClearColor == nil) {
            elementClearColor = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT] && elementText == nil) {
            elementText = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT_ALLIGNMENT] && elementAllign == nil) {
            elementAllign = [attributesProperties valueForKey:key];            
        }     
    }
    
    parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UILabel *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 
    
    if (elementText) {
        ((UILabel *)parsedObject.instance).text = elementText;
    }
    
    if (elementTransform) {
        ((UILabel *)parsedObject.instance).transform = CGAffineTransformMakeRotation([self transformValue:elementTransform]);
    }
    
    if (elementAllign) {
        ((UILabel *)parsedObject.instance).textAlignment = [self getAllignment:elementAllign];
    }
    
    if (elementClearColor && [elementClearColor isEqualToString:@"YES"]) {
        ((UILabel *)parsedObject.instance).backgroundColor = [UIColor clearColor];
    }    

}

- (UITextAlignment)getAllignment:(NSString *)allignmentValue{
    if ([allignmentValue isEqualToString:@"Center"]) {
        return UITextAlignmentCenter;
    } else if ([allignmentValue isEqualToString:@"Left"]) {
        return UITextAlignmentLeft;
    } else if ([allignmentValue isEqualToString:@"Right"]) {
        return UITextAlignmentRight;
    } else {
        return UITextAlignmentCenter;
    }
}

- (void)setUITextFieldAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementText = nil;
    NSString *elementAllign = nil;
    NSString *elementTransform = nil;
    NSString *elementBorderStyle = nil;
    NSString *elementBackground = nil;
    NSString *elementDisabledBackground = nil;
    
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TRANSFORM] && elementTransform == nil) {
            elementTransform = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT] && elementText == nil) {
            elementText = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT_ALLIGNMENT] && elementAllign == nil) {
            elementAllign = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_BORDER_STYLE] && elementBorderStyle == nil) {
            elementBorderStyle = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_BACKGROUND] && elementBackground == nil) {
            elementBackground = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_DISABLED_BACKGROUND] && elementDisabledBackground == nil) {
            elementDisabledBackground = [attributesProperties valueForKey:key];            
        }     
    }
    
    parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UITextField *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 
    
    if (elementText) {
        ((UITextField *)parsedObject.instance).text = elementText;
    }
    
    if (elementTransform) {
        ((UITextField *)parsedObject.instance).transform = CGAffineTransformMakeRotation([self transformValue:elementTransform]);
    }
    
    if (elementAllign) {
        ((UITextField *)parsedObject.instance).textAlignment = [self getAllignment:elementAllign];
    }
    
    if (elementBorderStyle) {
        ((UITextField *)parsedObject.instance).borderStyle = [self getBorderStyle:elementBorderStyle];
    }
    
    if (elementBackground) {
        ((UITextField *)parsedObject.instance).background = [UIImage imageNamed:elementBackground];
    }

    if (elementDisabledBackground) {
        ((UITextField *)parsedObject.instance).disabledBackground = [UIImage imageNamed:elementDisabledBackground];
    }
    
}

- (void)setUITextViewAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementText = nil;
    NSString *elementAllign = nil;
    NSString *elementTransform = nil;
    NSString *elementEditable = nil;
    
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TRANSFORM] && elementTransform == nil) {
            elementTransform = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT] && elementText == nil) {
            elementText = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_TEXT_ALLIGNMENT] && elementAllign == nil) {
            elementAllign = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_EDITABLE] && elementEditable == nil) {
            elementEditable = [attributesProperties valueForKey:key];            
        }   
    }
    
    parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UITextView *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 
    
    if (elementText) {
        ((UITextView *)parsedObject.instance).text = elementText;
    }
    
    if (elementTransform) {
        ((UITextView *)parsedObject.instance).transform = CGAffineTransformMakeRotation([self transformValue:elementTransform]);
    }
    
    if (elementAllign) {
        ((UITextView *)parsedObject.instance).textAlignment = [self getAllignment:elementAllign];
    }
    
    if (elementEditable) {
        if ([elementEditable isEqualToString:@"YES"]) {
            ((UITextView *)parsedObject.instance).editable = YES;
        } else if ([elementEditable isEqualToString:@"NO"]) {
            ((UITextView *)parsedObject.instance).editable = NO;
        } else {
            ((UITextView *)parsedObject.instance).editable = YES;
        }        
    }
       
}

- (UITextBorderStyle)getBorderStyle:(NSString *)borderStyleValue{    
    if ([borderStyleValue isEqualToString:@"None"]) {
        return UITextBorderStyleNone;
    } else if ([borderStyleValue isEqualToString:@"Line"]) {
        return UITextBorderStyleLine;
    } else if ([borderStyleValue isEqualToString:@"Bazel"]) {
        return UITextBorderStyleBezel;
    } else if ([borderStyleValue isEqualToString:@"RoundedRect"]) {
        return UITextBorderStyleRoundedRect;
    } else {
        return UITextBorderStyleNone;
    }
}

- (void)setUIImageViewAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementImageSource = nil;
    
    
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_IMAGE_SOURCE] && elementImageSource == nil) {
            elementImageSource = [attributesProperties valueForKey:key];            
        }   
    }
    
    parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UIImageView *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 

    if (elementImageSource) {
        ((UIImageView *)parsedObject.instance).image = [UIImage imageNamed:elementImageSource];        
    }
    
    
}

- (void)setUIToolbarAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    NSString *elementBarStyle = nil;
    
   
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attributesProperties valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_BAR_STYLE] && elementBarStyle == nil) {
            elementBarStyle = [attributesProperties valueForKey:key];            
        }   
    }
    
    parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (xPos != nil && yPos != nil && elementWidth != nil && elementHeight != nil) {
        ((UIToolbar *)parsedObject.instance).frame = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    } 
    
    if (elementBarStyle) {
        ((UIToolbar *)parsedObject.instance).barStyle = [self getBarStyle:elementBarStyle];
    }
    
    
    
}

- (UIBarStyle)getBarStyle:(NSString *)barStyleValue{
    if ([barStyleValue isEqualToString:@"UIBarStyleBlack"]) {
        return UIBarStyleBlack;
    } else if ([barStyleValue isEqualToString:@"UIBarStyleBlackOpaque"]) {
        return UIBarStyleBlackOpaque;
    } else if ([barStyleValue isEqualToString:@"UIBarStyleBlackTranslucent"]) {
        return UIBarStyleBlackTranslucent;
    } else if ([barStyleValue isEqualToString:@"UIBarStyleDefault"]) {
        return UIBarStyleDefault;
    } else {
        return UIBarStyleDefault;
    }

}

- (void)setUIBarButtonItemAttributes:(ParsedElement *)parsedObject{
    NSString *emID = nil;
    NSString *elementActionTarget = nil;
    NSString *elementButtonItemStyle = nil;
    NSString *elementSystemItemType = nil;
    NSString *elementTitle = nil;
    NSString *elementItemType = nil;
    NSString *elementViewType = nil;
    
    SEL actionTargetSelector = nil;
    
    //SEL selector = NSSelectorFromString(@"selectrName"); 
    //SEL selector = NSSelectorFromString(@"selectrName:"); 
    
    
    NSMutableDictionary *attributesProperties = parsedObject.attributesDict;
    NSArray *attributesKeys = [attributesProperties allKeys];
    
    for (NSString *key in attributesKeys) {
        if ([key isEqualToString:ELEMENT_ID] && emID == nil) {
            emID = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_ACTION_TARGET] && elementActionTarget == nil) {
            elementActionTarget = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_BUTTON_STYLE] && elementButtonItemStyle == nil) {
            elementButtonItemStyle = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_INIT_SYSTEM_TYPE] && elementSystemItemType == nil) {
            elementSystemItemType = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_TITLE] && elementTitle == nil) {
            elementTitle = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_INIT_TYPE] && elementItemType == nil) {
            elementItemType = [attributesProperties valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_VIEW_TYPE] && elementViewType == nil) {
            elementViewType = [attributesProperties valueForKey:key];   
        }   
    }
    
    //parsedObject.instance = [self createObjectWithID:parsedObject.type]; 
    
    if (emID) {
        parsedObject.viewId = emID;
    }    
    
    if (elementActionTarget) {
        actionTargetSelector = NSSelectorFromString(elementActionTarget);
    }
    
    if ([elementItemType isEqualToString:@"SystemItem"]) {
        parsedObject.instance = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:[self getBarButtonSystemItem:elementSystemItemType] target:self action:actionTargetSelector];
    } else if ([elementItemType isEqualToString:@"Custom"]) {
        parsedObject.instance = [[UIBarButtonItem alloc] initWithCustomView:[self generateCustomBarButtonItemByType:elementViewType]];
    } if ([elementItemType isEqualToString:@"Title"]) {
        parsedObject.instance = [[UIBarButtonItem alloc] initWithTitle:elementTitle style:[self getBarButtonItemStyle:elementButtonItemStyle] target:self action:actionTargetSelector];
    }
    
    
    
}

- (UIView *)generateCustomBarButtonItemByType:(NSString *)viewType{
    UIView *customView = nil;  
    if (viewType) {
        NSArray *titleStateElements = [viewType componentsSeparatedByString:@"~"];
        
        if ([[titleStateElements objectAtIndex:0] isEqualToString:@"Image"]) {
            customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[titleStateElements objectAtIndex:1]]];
        }
        
        
      
        
        
        
        
    } else {
        
    }
    
    return customView;
}

- (CGRect)generateCGRect:(NSArray *)attrArray{
    NSNumber *xPos = nil;
    NSNumber *yPos = nil;
    NSNumber *elementWidth = nil;
    NSNumber *elementHeight = nil;
    
    CGRect frameRect;
    
    for (NSString *key in attrArray) {
        if ([key isEqualToString:ELEMENT_XPOS] && xPos == nil) {
            xPos = [attrArray valueForKey:key];   
        } else if ([key isEqualToString:ELEMENT_YPOS] && yPos == nil) {
            yPos = [attrArray valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_WIDTH] && elementWidth == nil) {
            elementWidth = [attrArray valueForKey:key];            
        } else if ([key isEqualToString:ELEMENT_HEIGHT] && elementHeight == nil) {
            elementHeight = [attrArray valueForKey:key];            
        }  
    }
    
    if (xPos && yPos && elementWidth && elementHeight) {
        frameRect = CGRectMake([xPos floatValue], [yPos floatValue], [elementWidth floatValue], [elementHeight floatValue]);
    }
    
    return frameRect;    
}

- (NSArray *)setBarButtonItemsToParent:(ParsedElement *)parsedObject{
    NSMutableArray *childItems = [[NSMutableArray alloc] init];
    
    NSMutableArray *existingElements = parsedObject.parsedChildElements;
    
    for (ParsedElement *element in existingElements) {
        
        if (element.instance) {
            [childItems addObject:element.instance];
        }
        
    }
       
    return ((NSArray *)[childItems copy]);
}

- (UIBarButtonItemStyle)getBarButtonItemStyle:(NSString *)barButtonItemStyle{
    if ([barButtonItemStyle isEqualToString:@"Plain"]) {
        return UIBarButtonItemStylePlain;
    } else if ([barButtonItemStyle isEqualToString:@"Bordered"]) {
        return UIBarButtonItemStyleBordered;
    } else if ([barButtonItemStyle isEqualToString:@"Done"]) {
        return UIBarButtonItemStyleDone;
    } else {
        return UIBarButtonItemStylePlain;
    }
}

- (UIBarButtonSystemItem)getBarButtonSystemItem:(NSString *)barButtonSystemItemType{
    if ([barButtonSystemItemType isEqualToString:@"Done"]) {
        return UIBarButtonSystemItemDone;
    } else if ([barButtonSystemItemType isEqualToString:@"Cancel"]) {
        return UIBarButtonSystemItemCancel;
    } else if ([barButtonSystemItemType isEqualToString:@"Edit"]) {
        return UIBarButtonSystemItemEdit;
    } else if ([barButtonSystemItemType isEqualToString:@"Save"]) {
        return UIBarButtonSystemItemSave;
    } else if ([barButtonSystemItemType isEqualToString:@"Add"]) {
        return UIBarButtonSystemItemAdd;
    } else if ([barButtonSystemItemType isEqualToString:@"FlexibleSpace"]) {
        return UIBarButtonSystemItemFlexibleSpace;
    } else if ([barButtonSystemItemType isEqualToString:@"FixedSpace"]) {
        return UIBarButtonSystemItemFixedSpace;
    } else if ([barButtonSystemItemType isEqualToString:@"Compose"]) {
        return UIBarButtonSystemItemCompose;
    } else if ([barButtonSystemItemType isEqualToString:@"Reply"]) {
        return UIBarButtonSystemItemReply;
    } else if ([barButtonSystemItemType isEqualToString:@"Action"]) {
        return UIBarButtonSystemItemAction;
    } else if ([barButtonSystemItemType isEqualToString:@"Organize"]) {
        return UIBarButtonSystemItemOrganize;
    } else if ([barButtonSystemItemType isEqualToString:@"Bookmarks"]) {
        return UIBarButtonSystemItemBookmarks;
    } else if ([barButtonSystemItemType isEqualToString:@"Search"]) {
        return UIBarButtonSystemItemSearch;
    } else if ([barButtonSystemItemType isEqualToString:@"Refresh"]) {
        return UIBarButtonSystemItemRefresh;
    } else if ([barButtonSystemItemType isEqualToString:@"Stop"]) {
        return UIBarButtonSystemItemStop;
    } else if ([barButtonSystemItemType isEqualToString:@"Camera"]) {
        return UIBarButtonSystemItemCamera;
    } else if ([barButtonSystemItemType isEqualToString:@"Trash"]) {
        return UIBarButtonSystemItemTrash;
    } else if ([barButtonSystemItemType isEqualToString:@"Play"]) {
        return UIBarButtonSystemItemPlay;
    } else if ([barButtonSystemItemType isEqualToString:@"Pause"]) {
        return UIBarButtonSystemItemPause;
    } else if ([barButtonSystemItemType isEqualToString:@"Rewind"]) {
        return UIBarButtonSystemItemRewind;
    } else if ([barButtonSystemItemType isEqualToString:@"FastForward"]) {
        return UIBarButtonSystemItemFastForward;
    } else if ([barButtonSystemItemType isEqualToString:@"Undo"]) {
        return UIBarButtonSystemItemUndo;
    } else if ([barButtonSystemItemType isEqualToString:@"Redo"]) {
        return UIBarButtonSystemItemRedo;
    } else if ([barButtonSystemItemType isEqualToString:@"PageCurl"]) {
        return UIBarButtonSystemItemPageCurl;
    } else {
        return UIBarButtonSystemItemDone;
    }
                
}

- (void)parseXMLContextToObjects:(TBXMLElement *)element parsedObject:(ParsedElement *)parsedObject hasElements:(BOOL)hasElements{
    ParsedElement *parsedElement = nil;
    //ParsedElement *parsedElement = [[[ParsedElement alloc] init] autorelease];
    //parsedElement.parsedChildElements = [[NSMutableArray alloc] init];
    do {
        parsedElement = [[[ParsedElement alloc] init] autorelease];
        parsedElement.parsedChildElements = [[NSMutableArray alloc] init];
        TBXMLAttribute *attribute = element->firstAttribute;
        NSMutableDictionary *attrDict = nil;	
        if (attribute) {
            attrDict = [[[NSMutableDictionary alloc] init] autorelease];
            while (attribute) {
                [attrDict setObject:[TBXML attributeValue:attribute] forKey:[TBXML attributeName:attribute]];                
                attribute = attribute->next;
            }
            parsedElement.type = [TBXML elementName:element];
            parsedElement.attributesDict = attrDict;
            
            [self setAttributesToParsedElement:parsedElement];           
        }
                
        if (element->firstChild) {
            [self parseXMLContextToObjects: element->firstChild parsedObject:parsedElement hasElements:YES];                        
        }          
        
        if (hasElements == YES) {
            [parsedObject.parsedChildElements addObject:parsedElement];
        } else {                                    
            [self.contextObjects addObject:parsedElement];
        }         
                
    } while ((element=element->nextSibling));
            
}

- (UIView *)findViewById:(NSString *)viewId{  
    return [self findViewById:viewId childArray:self.contextObjects];
}

- (UIView *)findViewById:(NSString *)viewId childArray:(NSMutableArray *)childArray{
    UIView *instancedElement = nil;
    if (childArray) {
        for (ParsedElement *element in childArray) {
            if ([element.viewId isEqualToString:viewId]) {                
                return element.instance;            
            } else {
                if (element.parsedChildElements != nil && [element.parsedChildElements count] > 0) {
                    instancedElement = [self findViewById:viewId childArray:element.parsedChildElements];                    
                    if (instancedElement) {
                        return instancedElement;
                    }                    
                }
            }
        }
         
    }

    return instancedElement;
}

- (void)ifToolbarExistWithBarButtonItemsThenMakeConnection:(NSMutableArray *)parsedObjects{
    
    if (parsedObjects) {
        for (ParsedElement *element in parsedObjects) {
            if ([element.instance isKindOfClass:[UIToolbar class]] && [element.parsedChildElements count] > 0) {
                [(UIToolbar *)element.instance setItems:[self setBarButtonItemsToParent:element]];
            } else {
                if (element.parsedChildElements) {
                    [self ifToolbarExistWithBarButtonItemsThenMakeConnection:element.parsedChildElements];
                }                
            }
        }
    }
            
}

- (void)setupUIelements{
    for (ParsedElement *parsedObject in self.contextObjects) {
        [self setupUIelementsForView:nil childElement:parsedObject];
    }
}

- (void)setupUIelementsForView:(ParsedElement *)parentElement childElement:(ParsedElement *)childElement{
    
    if (childElement.parsedChildElements && [childElement.parsedChildElements count] > 0) {
        for (ParsedElement *parsedObject in childElement.parsedChildElements) {
            [self setupUIelementsForView:childElement childElement:parsedObject];
        }
    }
    
    if (parentElement == nil) {
        [self.parentView addSubview:childElement.instance];
    } else {
        
        if ([parentElement.type isEqualToString:@"UIView"]) {
            [(UIView *)parentElement.instance addSubview:childElement.instance];
        }
        
    }
    
}

- (void)dealloc{
    [self.xmlContext release];
    [self.contextObjects release];
    [self.tbXMLParser release];
    [super dealloc];
}

@end
