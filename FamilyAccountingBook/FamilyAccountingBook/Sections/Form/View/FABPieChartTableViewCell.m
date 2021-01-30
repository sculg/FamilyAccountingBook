//
//  FABPieChartTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/28.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABPieChartTableViewCell.h"

@interface FABPieChartTableViewCell ()<IChartValueFormatter>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) PieChartData *data;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSNumber *sum;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) NSArray *valueArr;

@property (nonatomic, strong) UIView *containerView;

@end


@implementation FABPieChartTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kDefaultBackgroundColor;
        [self.contentView addSubview:self.containerView];

        [self.containerView addSubview:self.titleLabel];
        [self.containerView addSubview:self.valueLabel];
        [self.containerView addSubview:self.lineView];
        [self.containerView addSubview:self.myChartView];
    }
    
    [self customLayout];
    return self;
}

-(void)configCellWithTitle:(NSString *)title
                  sumValue:(NSNumber *)sum
                   itemArr:(NSArray *)items
              itemValueArr:(NSArray *)itemValues{
    
    self.title = title;
    self.sum  = sum;
    self.itemArr = items;
    self.valueArr = itemValues;
}

#pragma mark - Super Methods

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel ss_setText:self.title
                                Font:kFontSize(16)
                           TextColor:kTitleTextColor
                     BackgroundColor:nil];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    NSString *myValue = [NSString stringWithFormat:@"%@%@",[StringHelper numberDoubleFormatterValue:[self.sum doubleValue]],kCashUnit];
    [self.valueLabel ss_setText:myValue
                           Font:kFontSize(16)
                      TextColor:kMainCommonColor
                BackgroundColor:nil];
    
    //为饼状图提供数据
    self.data = [self setData];
    self.myChartView.data = self.data;
    //设置动画效果
    [self.myChartView animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
    

}

- (void)customLayout {
    
    @weakify(self);
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-0);
        
    }];    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.mas_top).offset(6);
        make.left.equalTo(self).offset(16);
        make.width.equalTo(@(kScreenWidth * 0.6));
        make.height.equalTo(@(38));
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.mas_top).offset(6);
        make.right.equalTo(self.mas_right).offset(-16);
        make.width.equalTo(@(kScreenWidth * 0.4));
        make.height.equalTo(@(38));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(1);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    [self.myChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(46);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-6);
    }];
}

#pragma mark - Property
- (PieChartView *)myChartView {
    if (!_myChartView) {
        _myChartView = [[PieChartView alloc] init];
        self.myChartView.backgroundColor = [UIColor whiteColor];
        //基本样式
        self.myChartView.noDataText = NSLocalizedString(@"No data",nil);// 设置没有数据的显示内容
        [self.myChartView setExtraOffsetsWithLeft:30 top:10 right:30 bottom:10];//饼状图距离边缘的间隙
        self.myChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
       self.myChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
//        self.myChartView.drawSliceTextEnabled = YES;//是否显示区块文本
        //空心饼状图样式
        self.myChartView.drawHoleEnabled = YES;//饼状图是否是空心
        self.myChartView.holeRadiusPercent = 0.5;//空心半径占比
        self.myChartView.holeColor = [UIColor clearColor];//空心颜色
        self.myChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
       self.myChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
        //实心饼状图样式
            self.myChartView.drawHoleEnabled = NO;
        //饼状图中间描述
        if (self.myChartView.isDrawHoleEnabled == YES) {
            self.myChartView.drawCenterTextEnabled = YES;//是否显示中间文字
            //普通文本
            //        self.pieChartView.centerText = @"饼状图";//中间文字
            //富文本
            NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Expenditure",nil)];
            [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                        NSForegroundColorAttributeName: [UIColor orangeColor]}
                                range:NSMakeRange(0, centerText.length)];
            self.myChartView.centerAttributedText = centerText;
        }
        //饼状图描述
//        self.myChartView.descriptionText = @"";
//        self.myChartView.descriptionFont = [UIFont systemFontOfSize:10];
//        self.myChartView.descriptionTextColor = [UIColor grayColor];
        //饼状图图例
        
        self.myChartView.legend.maxSizePercent = 10;//图例在饼状图中的大小占比, 这会影响图例的宽高
        self.myChartView.legend.formToTextSpace = 6;//文本间隔
        self.myChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
        self.myChartView.legend.textColor = [UIColor grayColor];//字体颜色
//        self.myChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
        self.myChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
        self.myChartView.legend.formSize = 12;//图示大小
        
       
    }
    return _myChartView;
}


- (void)updateData{
    //为饼状图提供数据
    self.data = [self setData];
    self.myChartView.data = self.data;
}

- (PieChartData *)setData{
    
    int count = (int)[self.valueArr count];//饼状图总共有几块组成
    //每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSNumber *value = _valueArr[i];
        double value1 = (double)[value doubleValue];
        if (value1 != 0) {
        [yVals addObject:[[PieChartDataEntry alloc] initWithValue:value1 label:_itemArr[i] icon:[UIImage imageNamed:@""]]];
        }
    }
    
    if ([yVals count] != 0) {
        //dataSet
        PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:yVals label:@""];
        dataSet.drawValuesEnabled = YES;//是否绘制显示数据
        NSMutableArray *colors = [[NSMutableArray alloc] init];
//        [colors addObject:kMainCommonOppositionColor];
//        [colors addObject:kMainCommonColor];//橙色
        [colors addObject:UIColorFromRGB(0xF79F79)];
        [colors addObject:UIColorFromRGB(0xE2CFC8)];
        
        [colors addObject:UIColorFromRGB(0xDDA59D)];
        
        [colors addObject:UIColorFromRGB(0xF5F2E9)];
        [colors addObject:UIColorFromRGB(0xC1BAC1)];
        [colors addObject:UIColorFromRGB(0x87B6A7)];
        
        [colors addObject:UIColorFromRGB(0xF7D08A)];
        
        [colors addObject:UIColorFromRGB(0xF3E6DE)];
        [colors addObject:UIColorFromRGB(0xE3F09B)];
        [colors addObject:UIColorFromRGB(0x5B5941)];//黑色
        
        
        
        
        dataSet.colors = colors;//区块颜色
        dataSet.sliceSpace = 1;//相邻区块之间的间距
        dataSet.selectionShift = 8;//选中区块时, 放大的半径
        dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
        dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
        //数据与区块之间的用于指示的折线样式
        dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
        dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
        dataSet.valueLineWidth = 1;//折线的粗细
        dataSet.valueLineColor = [UIColor brownColor];//折线颜色
        
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        
        data.valueFormatter = self;
        [data setValueTextColor:[UIColor brownColor]];
        [data setValueFont:[UIFont systemFontOfSize:10]];
        
        return data;

    }else{
        return nil;
    }
}

- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler SWIFT_WARN_UNUSED_RESULT{
    
    return [NSString stringWithFormat:@"%1.f%% (%@ %@)",value,[StringHelper numberDoubleFormatterValue:entry.y],kCashUnit];
    
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.layer.masksToBounds = YES;
        self.containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        self.valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kTCellLineMiddleColor;
    }
    return _lineView;
}


@end
