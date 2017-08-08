//
//  JWImagePicker.h
//  gloryShip
//
//  Created by WangWenjie on 15/1/19.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JWImagePickerBlock) (UIViewController * ctrl,UIImage * image);

@interface JWImagePicker : NSObject<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) JWImagePickerBlock  block;
@property (strong,nonatomic) UIViewController * ctrl;
@property (strong,nonatomic) NSString * title;

+ (JWImagePicker *)shareInstance:(UIViewController *)ctrl title:(NSString *)title block:(JWImagePickerBlock)block;
-(void)chooseImage;



@end
