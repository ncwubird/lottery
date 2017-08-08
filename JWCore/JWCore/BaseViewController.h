//
//  BaseViewController.h
//  JWCore
//
//  Created by JayWong on 16/6/1.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BAR_BTN_TYPE){
    BAR_BTN_BACK,                           // 返回按钮（默认灰色）
    BAR_BTN_BACK_WHITE,                     // 返回按钮（白色）
    BAR_BTN_NONE,                           // 空白按钮
    BAR_BTN_MEMBER_CENTER,                  // 个人中心
    BAR_BTN_SHARE,                          // 分享
    BAR_BTN_GPS,                            // GPS
    BAR_BTN_MESSAGE,                        // 消息
    BAR_BTN_SHOPPING_CAR,                   // 购物车
    BAR_BTN_CLASSIFICATION,                 // 分类
    BAR_BTN_DISCOVERY_FINISH,               // 栏目定制 完成
    BAR_BTN_MISSION_FINISH,                 // 任务完成
    BAR_BTN_SAVE_INFO,                      // 保存用户信息
    BAR_BTN_REWARD_DETAIL,                  // 收益明细
    BAR_BTN_WEB_CROSS,                      // 网页返回
    BAR_BTN_INVITE_RECODER,                 // 邀请记录
    
    BAR_BTN_TRACK_HISTORY,                  // 轨迹历史记录
    BAR_BTN_BACK_TRACK,                     // 轨迹返回
    BAR_BTN_TRACK_SHARE,                    // 轨迹分享
    BAR_BTN_SAVE,                           // 修改密码
    BAR_BTN_COMMIT,                         // 提交
    BAR_BTN_MEDICALRECODER,                 // 病历
    BAR_BTN_QRCODE,                         // 二维码


};

@interface BaseViewController : UIViewController

/**
 *  创建导航栏按钮
 */
- (void)addNavBar:(NSString *)title leftBtn:(BAR_BTN_TYPE)leftBtnType rightBtn:(BAR_BTN_TYPE)rightBtnType;



-(void)navBarAction_Search;

//keyBoard
-(void)setReturnKeyTypeAndDelegateForTextfield:(UITextField *)textField;

-(void)setDelegateAndNumberKeyboardForTextfield:(UITextField *)textField type:(UIKeyboardType)type;
@end
