//
//  CommunityAnnouncementCell.h
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityAnnouncementCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;


@end
