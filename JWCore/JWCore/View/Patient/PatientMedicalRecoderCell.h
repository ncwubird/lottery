//
//  PatientMedicalRecoderCell.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/28.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientMedicalRecoderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *medicalLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;

@end
