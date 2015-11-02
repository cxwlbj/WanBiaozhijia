//
//  CityView.m
//  Project3-CHIP
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "CityView.h"
#import "BrandModel.h"
@implementation CityView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"deep.png"]];
    
}

- (void)setCityData:(NSArray *)cityData{
    if (_cityData != cityData) {
        _cityData = cityData;
        [self.pickerView reloadAllComponents];
    }
}

- (void)setBuyData:(NSArray *)buyData{
    if (_buyData != buyData) {
        _buyData = buyData;
        [self.pickerView reloadAllComponents];
    }
}

#pragma mark - BtnClick
- (IBAction)sureAction:(UIButton *)sender {
    
    BrandModel *model = _cityData[_cityIndex];
//    NSString *cityid = model.cityID;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityID" object:model];
    self.transform = CGAffineTransformMakeTranslation(0, self.height + 50);
}

- (IBAction)cancel:(UIButton *)sender {
    
    self.transform = CGAffineTransformMakeTranslation(0, self.height + 50);
}



#pragma mark -UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_isCity) {
        
        return _cityData.count;
    }
    return _buyData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_isCity) {
//        if (_cityIndex != row && _cityIndex != 0) {
//            row = _cityIndex;
//            return [_cityData[_cityIndex] name];
//        }
        return [_cityData[row] name];
    }
    
    return [_buyData[row] name];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_isCity) {
//        if (_cityIndex != row) {
//            _cityIndex = row;
//        }
        _cityIndex = row;
    }
//    else{
//        if (_buyIndex != row) {
//            _buyIndex = row;
//        }
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
