//
//  CityView.h
//  Project3-CHIP
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _cityIndex;
    NSInteger _buyIndex;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *cityData;
@property (nonatomic, strong) NSArray *buyData;
@property (nonatomic, assign) BOOL isCity;


@end
