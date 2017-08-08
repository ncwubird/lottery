//
//  RequestAddress.h
//  JWCore
//
//  Created by JayWong on 16/9/5.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#ifndef RequestAddress_h
#define RequestAddress_h

/*my*/

#define KHOME_MEMBERCENTER @"Ucenter_Index.Index"                            //个人中心数据

#define KHOME_IMAGE_UPLOAD @"CDN_File.UploadImage"                           //图片上传
#define KHOME_MEMBERE_UPDATEUSERHEAD @"User_Info.UpdateInfo"                 //更新用户头像等用户信息
#define KHOME_MEMBERE_UPDATEDOCTORINFO @"Doctor_Info.UpdateDoctorInfo"       //更新医生信息
#define KHOME_MEMBERE_GETDOCTORINFO @"Doctor_Info.Info"       //湖获取医生个人信息
#define KHOME_MEMBERE_GETTAGS @"SYS_Tags.GetTags"                            //获取标签
#define KHOME_MEMBERE_GETBANKLIST @"SYS_Bank.GetBank"                        //获取银行列表
#define KHOME_MEMBERE_SETBANKCARD @"Doctor_Account.SetBankCard"               //设置银行卡
#define KHOME_MEMBERE_UPDATEBANKCARD @"Doctor_Account.UpdateBankCard"               //更新银行卡
#define KHOME_MEMBERE_GETACCOUNRINFO @"Doctor_Account.GetInfo"                  //获取账户信息
#define KHOME_MEMBERE_GETACCOUNRRECODER @"Doctor_Account.GetRecord"                  //获取账户记录



#define KHOME_MEMBERE_GETDEPARTMENT @"SYS_Department.GetInfo"                  //获取科室
#define KHOME_MEMBERE_GETJOBTITLE @"SYS_Jobtitle.GetInfo"                      //获取职称
#define KHOME_MEMBERE_PROROL @"http://wap.ddknows.com/company/doctoragreement.html"                      //协议

#define KHOME_MEMBERE_ABOUTUS @"http://wap.ddknows.com/company/aboutus.html"                      //关于我们

#define KHOME_MEMBERE_FEEDBACK @"SYS_Feedback.InsertUserFeedback"                      //意见反馈

/*user*/

#define KUSER_LOGON @"User_Login.Client"                                      //手机号登录

#define KUSER_REGISTER_CODE @"SMS_Code.GetRegCode"                           //注册获取验证码

#define KUSER_REGISTER @"User_Register.Mobile"                               //手机注册


#define KUSER_REGISTER_SETTING @"/Authentication/Profile/RegisterHeadPost/alt/json"

#define KUSER_FORGET_PASSWORD_CODE @"SMS_Code.GetForgetPwdCode"               //找回密码获取验证码

#define KUSER_FORGET_PASSWORD @"User_Forget.UpdatePwd"                        //找回密码

#define KUSER_EXIT @"User_Logout.Action"                                      //退出登录
#define KUSER_CHANGE_PASSWORD @"User_Info.UpdatePwd"                                      //修改登录


/*patient*/

#define KUSER_PATIENT_LIST @"Client_Info.GetMyPatientInfo"                                      //获取患者列表和服务情况

#define KUSER_PATIENT_RECODER @"Client_Info.GetMyPatientRecord"                                      //获取单个用户病历记录
#define KUSER_PATIENT_DETAIL @"Client_Info.GetMyPatientRecordDetail"                                      //获取单个用户病历详情

#define KUSER_PATIENT_BASEDETAIL @"Client_Info.GetMyPatientDetail"                                      //获取单个患者基本信息
/*message*/

#define KUSER_MESSAGE_ALLINFO @"User_Info.GetUserAllInfo"                                      //获取当前用户环信信息

/*message*/

#define KMESSAGE_SYSTEM_ALLINFO @"Message_Sys.GetAll"                                      //获取系统信息


#endif /* RequestAddress_h */
