//
//  RootNavigationViewController.m
//  JWCore
//
//  Created by JayWong on 16/9/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "RootNavigationViewController.h"
#import "RootTabbarViewController.h"
#import "SPLaughView.h"
//#import "SettingsViewController.h"
//#import "ApplyViewController.h"
#import "ChatViewController.h"
//#import "UserProfileManager.h"
#import "ConversationListController.h"
//#import "ContactListViewController.h"
//#import "ChatDemoHelper.h"
//#import "RedPacketChatViewController.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface RootNavigationViewController ()<EMChatManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation RootNavigationViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;  //只允许执行一次（以防分享和选择图片跳转回来执行）
    dispatch_once(&onceToken, ^{
        [self startLaugh];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReloginAlert) name:KUSER_LOGIN_INVALID object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
//    
//    [self setupUnreadMessageCount];
//    [self setupUntreatedApplyCount];
    
    //[ChatDemoHelper shareHelper].contactViewVC = _contactsVC;
    //[ChatDemoHelper shareHelper].conversationListVC = _chatListVC;

}
/*
// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
//    if (_chatListVC) {
//        if (unreadCount > 0) {
//            //_chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            //_chatListVC.tabBarItem.badgeValue = nil;
//        }
//    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (void)setupUntreatedApplyCount
{
//    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
//    if (_contactsVC) {
//        if (unreadCount > 0) {
//            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            _contactsVC.tabBarItem.badgeValue = nil;
//        }
//    }
}

- (void)networkChanged:(EMConnectionState)connectionState
{
//    _connectionState = connectionState;
//    [_chatListVC networkChanged:connectionState];
}
*/
#pragma mark -登陆失效,重新登陆

-(void)showReloginAlert{
    if ([SysFunctions keyWindow]==[[[UIApplication sharedApplication] delegate] window]) {//无AlertView
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:nil message:@"登录已失效,是否重新登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {//重新登录
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"退出成功");
        }
 
     [SysFunctions presentLogonViewController];
 }
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
}
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}
/*
#pragma mark - 自动登录回调

- (void)willAutoReconnect{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *showreconnect = [ud objectForKey:@"identifier_showreconnect_enable"];
    if (showreconnect && [showreconnect boolValue]) {
        [self hideHud];
        [self showHint:NSLocalizedString(@"reconnection.ongoing", @"reconnecting...")];
    }
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *showreconnect = [ud objectForKey:@"identifier_showreconnect_enable"];
    if (showreconnect && [showreconnect boolValue]) {
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"reconnection.fail", @"reconnection failure, later will continue to reconnection")];
        }else{
            [self showHint:NSLocalizedString(@"reconnection.success", @"reconnection successful！")];
        }
    }
}

- (EMConversationType)conversationTypeFromMessageType:(EMChatType)type
{
    EMConversationType conversatinType = EMConversationTypeChat;
    switch (type) {
        case EMChatTypeChat:
            conversatinType = EMConversationTypeChat;
            break;
        case EMChatTypeGroupChat:
            conversatinType = EMConversationTypeGroupChat;
            break;
        case EMChatTypeChatRoom:
            conversatinType = EMConversationTypeChatRoom;
            break;
        default:
            break;
    }
    return conversatinType;
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo)
    {
        if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]]) {
            //            ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
            //            [chatController hideImagePicker];
        }
        
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[ChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = userInfo[kConversationChatter];
                    ChatViewController *chatViewController = (ChatViewController *)obj;
                    if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        EMChatType messageType = [userInfo[kMessageType] intValue];
#ifdef REDPACKET_AVALABLE
                        chatViewController = [[RedPacketChatViewController alloc]
#else
                                              chatViewController = [[ChatViewController alloc]
#endif
                                                                    initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                                              switch (messageType) {
                                                  case EMChatTypeChat:
                                                  {
                                                      NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                                                      for (EMGroup *group in groupArray) {
                                                          if ([group.groupId isEqualToString:conversationChatter]) {
                                                              chatViewController.title = group.subject;
                                                              break;
                                                          }
                                                      }
                                                  }
                                                      break;
                                                  default:
                                                      chatViewController.title = conversationChatter;
                                                      break;
                                              }
                                              [self.navigationController pushViewController:chatViewController animated:NO];
                                              }
                                              *stop= YES;
                                              }
                                              }
                                              else
                                              {
                                                  ChatViewController *chatViewController = nil;
                                                  NSString *conversationChatter = userInfo[kConversationChatter];
                                                  EMChatType messageType = [userInfo[kMessageType] intValue];
#ifdef REDPACKET_AVALABLE
                                                  chatViewController = [[RedPacketChatViewController alloc]
#else
                                                                        chatViewController = [[ChatViewController alloc]
#endif
                                                                                              initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                                                                        switch (messageType) {
                                                                            case EMChatTypeGroupChat:
                                                                            {
                                                                                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                                                                                for (EMGroup *group in groupArray) {
                                                                                    if ([group.groupId isEqualToString:conversationChatter]) {
                                                                                        chatViewController.title = group.subject;
                                                                                        break;
                                                                                    }
                                                                                }
                                                                            }
                                                                                break;
                                                                            default:
                                                                                chatViewController.title = conversationChatter;
                                                                                break;
                                                                        }
                                                                        [self.navigationController pushViewController:chatViewController animated:NO];
                                                                        }
                                                                        }];
                                              }
//                                              else if (_chatListVC)
//                                              {
//                                                  [self.navigationController popToViewController:self animated:NO];
//                                                  [self setSelectedViewController:_chatListVC];
//                                              }
                                              }

*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)startLaugh{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    /* if ([[SysParams sharedInstance] showGuideView]) {
        SPLaughView * laughScroll=[[SPLaughView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,KSCREEN_HEIGHT)];
        [window addSubview:laughScroll];
        [window bringSubviewToFront:laughScroll];
    }else if (![SysParams isLogon]) {
        [SysFunctions presentLogonViewController];
    }*/
    if (![SysParams isLogon]){
        [SysFunctions presentLogonViewController];}
}


@end
