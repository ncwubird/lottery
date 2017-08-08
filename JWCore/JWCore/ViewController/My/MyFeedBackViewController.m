//
//  MyFeedBackViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyFeedBackViewController.h"
#import "MyViewModel.h"

@interface MyFeedBackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderLbl;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MyFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"意见反馈" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_COMMIT];
    [self.textView setDelegate:self];
    [self.textView setReturnKeyType:UIReturnKeyDone];

}
-(void)navBarAction_Commit:(UIButton *)sender{
    if ([NSString isEmptyString:self.textView.text]) {
        [JWProgressView showErrorWithStatus:@"请填写反馈意见!"];
        return;
    }
    [self feedBackRequest];
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

#pragma mark -request

-(void)feedBackRequest{
    MyViewModel * viewModel=[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            
            [JWProgressView showSuccessWithStatus:@"提交成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
                  }
    } WithFailureBlock:^{
        
    }];
    NSMutableDictionary * params=[viewModel feedBackRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] content:self.textView.text];
    
    [viewModel feedBackTaskWithParams:params];
}

-(void)back
{
    [self pop:YES];
}
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
