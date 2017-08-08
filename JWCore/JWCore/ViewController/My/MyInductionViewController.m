//
//  MyInductionViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyInductionViewController.h"
#import "MyPersonalInformationViewController.h"
#import "MyViewModel.h"
@interface MyInductionViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLbl;
@end

@implementation MyInductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"个人简介" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_SAVE];
    [self.textView setReturnKeyType:UIReturnKeyDone];
}

-(void)navBarAction_Save:(UIButton *)sender
{
  if ([NSString isEmptyString:self.textView.text]) {
     [JWProgressView showErrorWithStatus:@"还未填写个人简介!"];
     return;
   }
    [self commitSuggestion];
}

-(void)commitSuggestion
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            
           [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
           [self performSelector:@selector(goBack) withObject:nil afterDelay:0.1];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [params setObject:self.textView.text forKey:@"summary"];
    [viewModel updateUserInfoTaskWithParams:params];
}

-(void)goBack
{
    [[[[SysParams sharedInstance] logonModel] homeModel] setSummary:self.textView.text];
    [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
    
    NSArray *viewC = [self.navigationController viewControllers];
    MyPersonalInformationViewController *vc = [viewC objectAtIndex:1];
    vc.personalIntroduceLabel.text =self.textView.text;
     CGSize size = [self.textView.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    vc.personalIntroduceLabel.textAlignment = KSCREEN_WIDTH -90-size.width >0?NSTextAlignmentRight:NSTextAlignmentLeft;
    
    [self.navigationController popToViewController:vc animated:YES];
}
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

#pragma mark UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self.placeholderLbl setHidden:YES];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        [self.placeholderLbl setHidden:NO];
    }else{
        [self.placeholderLbl setHidden:YES];
    }
}

@end
