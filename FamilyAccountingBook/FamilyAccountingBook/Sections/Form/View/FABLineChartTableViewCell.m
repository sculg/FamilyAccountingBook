//
//  FABLineChartTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/29.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABLineChartTableViewCell.h"

@interface FABLineChartTableViewCell ()<ChartViewDelegate,IChartAxisValueFormatter,IChartValueFormatter>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UIView *lineView;

//@property (nonatomic, strong) ChartData *data;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *incomeItems;
@property (nonatomic, strong) NSArray *expenditureItems;
@property (nonatomic, strong) NSArray *monthItems;
@property (nonatomic, strong) UIView *containerView;

@end


@implementation FABLineChartTableViewCell

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
                 incomeArr:(NSArray *)incomeItems
            expenditureArr:(NSArray *)expenditureItems
                  monthArr:(NSArray *)monthItems{
    self.title = title;
    self.incomeItems = incomeItems;
    self.expenditureItems = expenditureItems;
    self.monthItems = monthItems;
}


#pragma mark - Super Methods

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel ss_setText:self.title
                           Font:kFontSize(16)
                      TextColor:kTitleTextColor
                BackgroundColor:nil];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.valueLabel ss_setText:kCashUnit
                           Font:kFontSize(16)
                      TextColor:kMainCommonColor
                BackgroundColor:nil];
    
    [self setDataCount:8];
    
}

- (void)customLayout {
    
    @weakify(self);
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(6);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-0);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.mas_top).offset(9);
        make.left.equalTo(self).offset(16);
        make.width.equalTo(@(kScreenWidth * 0.45));
        make.height.equalTo(@(38));
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.mas_top).offset(9);
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
        make.top.equalTo(self).offset(49);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-3);
    }];
}

#pragma mark - Property
- (LineChartView *)myChartView {
    if (!_myChartView) {
        _myChartView = [[LineChartView alloc] init];
        self.myChartView.backgroundColor = [UIColor whiteColor];
        self.myChartView.noDataText = NSLocalizedString(@"No data",nil);// 设置没有数据的显示内容
        self.myChartView.chartDescription.enabled = YES;
        self.myChartView.dragEnabled = YES;
//        self.myChartView.descriptionText = @"";//隐藏描述文字
        self.myChartView.legend.enabled = YES;//显示图例说明
        self.myChartView.scaleYEnabled = YES;//取消Y轴缩放
        self.myChartView.scaleXEnabled = NO;//取消X轴缩放
        self.myChartView.scaleEnabled = YES;// 缩放
        self.myChartView.delegate = self;// 代理
        self.myChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.myChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.myChartView.dragDecelerationFrictionCoef = 0;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        self.myChartView.rightAxis.enabled = NO;//不绘制右边轴的信息
        self.myChartView.leftAxis.enabled = NO;//不绘制左边轴的信息
        
        self.myChartView.extraRightOffset = 25;
        self.myChartView.extraLeftOffset = 25;
        self.myChartView.xAxis.enabled = YES;
        self.myChartView.xAxis.drawAxisLineEnabled = YES;
        self.myChartView.xAxis.drawGridLinesEnabled = NO;//不绘制网络线
        self.myChartView.xAxis.axisLineColor = [UIColor whiteColor];// x 轴的网络线颜色
//        self.myChartView.xAxis.centerAxisLabelsEnabled = YES;
        self.myChartView.xAxis.granularityEnabled = NO;
        
        self.myChartView.xAxis.granularity = 1;// 间隔为1
        self.myChartView.xAxis.valueFormatter = self;
        self.myChartView.xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        
        self.myChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
        self.myChartView.legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        self.myChartView.legend.orientation = ChartLegendOrientationHorizontal;
        self.myChartView.legend.drawInside = NO;
        
    }
    return _myChartView;
}


- (void)setDataCount:(int)count
{
    
    if ([_incomeItems count] == 1 && [_incomeItems[0] doubleValue] == 0 && [_expenditureItems count] == 1 && [_expenditureItems[0] doubleValue] == 0) {
        self.myChartView.data = nil;
    }else{
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_incomeItems count]; i++)
    {
        NSNumber *value = _expenditureItems[i];
        double value1 = (double)[value doubleValue];
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:value1]];
    }
    
    NSMutableArray *values1 = [[NSMutableArray alloc] init];

    for (int i = 0; i < [_incomeItems count]; i++)
    {
        NSNumber *value = _incomeItems[i];
        double value2 = (double)[value doubleValue];
        [values1 addObject:[[ChartDataEntry alloc] initWithX:i y:value2]];
    }

    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithEntries:values label:[NSString stringWithFormat:NSLocalizedString(@"Expenditure",nil)]];
    //对于线的各种设置
    set1.drawValuesEnabled = YES;//不显示文字
    set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set1.highlightColor = [UIColor clearColor];// 十字线颜色
    set1.drawCirclesEnabled = YES;//是否绘制拐点
    set1.cubicIntensity = 0.2;// 曲线弧度
    set1.circleRadius = 4.0f;//拐点半径
    set1.drawCircleHoleEnabled = NO;//是否绘制中间的空心
    set1.circleHoleRadius = 4.0f;//空心的半径
    set1.circleHoleColor = [UIColor whiteColor];//空心的颜色
    set1.circleColors = @[UIColorFromRGB(0x87B6A7)];
    set1.mode = LineChartModeHorizontalBezier;// 模式为曲线模式
    set1.drawFilledEnabled = YES;//是否填充颜色
    if ([self.title isEqualToString:@"近日收支变化"]) {
        set1.highlightColor = kMainCommonOppositionColor;
        set1.highlightLineWidth = 0.5;
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
    }
    

    // 设置渐变效果
    [set1 setColor:UIColorFromRGB(0x87B6A7)];//折线颜色
    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#87B6A7"].CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    set1.fillAlpha = 0.8f;//透明度
    set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    
    
    
        LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithEntries:values1 label:[NSString stringWithFormat:NSLocalizedString(@"Income",nil)]];
//    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithValues:values1 label:[NSString stringWithFormat:NSLocalizedString(@"Income",nil)]];
    //对于线的各种设置
    set2.drawValuesEnabled = YES;//不显示文字
    set2.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set2.highlightColor = [UIColor clearColor];// 十字线颜色
    set2.drawCirclesEnabled = YES;//是否绘制拐点
    set2.cubicIntensity = 0.2;// 曲线弧度
    set2.circleRadius = 4.0f;//拐点半径
    set2.drawCircleHoleEnabled = NO;//是否绘制中间的空心
    set2.circleHoleRadius = 4.0f;//空心的半径
    set2.circleHoleColor = [UIColor whiteColor];//空心的颜色
    set2.circleColors = @[UIColorFromRGB(0xF79F79)];
    set2.mode = LineChartModeHorizontalBezier;// 模式为曲线模式
    set2.drawFilledEnabled = YES;//是否填充颜色
    
    if ([self.title isEqualToString:@"近日收支变化"]) {
        set2.highlightColor = kMainCommonColor;
        set2.highlightLineWidth = 0.5;
        set2.highlightLineDashLengths = @[@5.f, @2.5f];
    }

        // 设置渐变效果        [colors addObject:UIColorFromRGB(0x87B6A7)];
    [set2 setColor:UIColorFromRGB(0xF79F79)];//折线颜色
    NSArray *gradientColors1 = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                 (id)[ChartColorTemplates colorFromString:@"#F79F79"].CGColor];
    CGGradientRef gradientRef1 = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors1, nil);
    set2.fillAlpha = 0.8f;//透明度
    set2.fill = [ChartFill fillWithLinearGradient:gradientRef1 angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef1);//释放gradientRef
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set2];
    [dataSets addObject:set1];
        
       
    
    // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    data.valueFormatter = self;
    self.myChartView.data = data;
        
    }
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    //    return self.xTitles[(int)value % self.monthTitles.count];
    int value1 = (int)value;
    if (value1 >= 0 && value1 <
        [_monthItems count]) {
        return _monthItems[value1];
    }
    return nil;
}


- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler SWIFT_WARN_UNUSED_RESULT{
    if (entry.y > 0) {
        return [NSString stringWithFormat:@"%@",[StringHelper numberDoubleFormatterValue:entry.y]];
    }else{
        return [NSString stringWithFormat:@"0"];
    }
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
