//
//  SLActionSheetTimePicker.m
//  SmartLife
//
//  Created by han on 2017/3/31.
//
//

#import "SLActionSheetTimePicker.h"


@interface SLActionSheetTimePicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, copy) actionTimeDoneBlock doneBlock;
@property (nonatomic, copy) actionTimeCancelBlock cancelBlock;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *backgroundView, *contentView, *actionView;
@property (nonatomic, strong) UIButton *doneBtn, *cancelBtn;
@property (nonatomic, strong) UIPickerView *timePickerView;
@property (nonatomic, strong) UIView *componentTitleView;
@property (nonatomic, strong) NSMutableArray *hourArray, *minuteArray, *secondArray;
@property (nonatomic, assign) NSInteger selectedHour, selectedMinute, selectedSecond;
@property (nonatomic, assign, readonly) NSInteger totalSeconds;
@property (nonatomic, assign) NSInteger curSecond;
@end

@implementation SLActionSheetTimePicker

- (instancetype)initWithTitle:(NSString *)title curSecond:(NSInteger)curSecond doneBlock:(actionTimeDoneBlock)doneBlock cancelBlock:(actionTimeCancelBlock)cancelBlock {
    self = [super init];
    if (self) {
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
        self.title = title;
        self.curSecond = curSecond;
        [self initDataArray];
        [self initUI];
        
        if (self.curSecond > 0) {
            self.selectedHour = self.curSecond / 3600;
            self.selectedMinute = (self.curSecond - self.selectedHour * 3600) / 60;
            self.selectedSecond = self.curSecond - self.selectedHour * 3600 - self.selectedMinute * 60;
            [_timePickerView selectRow:self.selectedHour inComponent:0 animated:NO];
            [_timePickerView selectRow:self.selectedMinute inComponent:1 animated:NO];
            [_timePickerView selectRow:self.selectedSecond inComponent:2 animated:NO];
        }
    }
    return self;
}

- (void)initUI {
    self.frame = [UIScreen mainScreen].bounds;
    
    // 初始化遮罩视图
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = RGBA(0, 0, 0, 0);
    [self addSubview:_backgroundView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 260)];
    _contentView.backgroundColor = [UIColor hexChangeFloat:@"f7f7f7"];
    [self addSubview:_contentView];
    
    _actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [_contentView addSubview:_actionView];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize: __kSL_Text_16];
    [_doneBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_01] forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionView addSubview:_doneBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize: __kSL_Text_16];
    [_cancelBtn setTitleColor:[UIColor hexChangeFloat:__kSL_Blue_01] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_actionView addSubview:_cancelBtn];
    
    _timePickerView = [[UIPickerView alloc] init];
    _timePickerView.delegate = self;
    _timePickerView.dataSource = self;
    [_contentView addSubview:_timePickerView];
    
    _componentTitleView = [[UIView alloc] init];
    _componentTitleView.backgroundColor = [UIColor clearColor];
    _componentTitleView.layer.borderWidth = .5f;
    _componentTitleView.layer.borderColor = [[UIColor hexChangeFloat:__kSL_Gray_01] CGColor];
    UILabel *hourLabel = [[UILabel alloc] init];
    hourLabel.text = @"时";
    UILabel *minuteLabel = [[UILabel alloc] init];
    minuteLabel.text = @"分";
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.text = @"秒";
    [_componentTitleView addSubview:hourLabel];
    [_componentTitleView addSubview:minuteLabel];
    [_componentTitleView addSubview:secondLabel];
    [_contentView addSubview:_componentTitleView];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.actionView);
    }];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.actionView);
    }];
    
    [_timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.size.width - 16);
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(44);
        make.height.mas_equalTo(216);
    }];
    
    [_componentTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.size.width);
        make.center.equalTo(self.timePickerView);
        make.height.mas_equalTo(34);
    }];
    
    [minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.componentTitleView);
        make.centerX.mas_equalTo(self.componentTitleView.mas_centerX).offset(30);
    }];
    
    [hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.componentTitleView);
        make.right.mas_equalTo(minuteLabel.mas_left).offset(-__gScreenWidth / 3 + 20);
    }];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.componentTitleView);
        make.right.mas_equalTo(minuteLabel.mas_right).offset(__gScreenWidth / 3);
    }];
    
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
}

- (void)initDataArray {
    _hourArray = [[NSMutableArray alloc] init];
    _minuteArray = [[NSMutableArray alloc] init];
    _secondArray = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
    for(int i = 0; i < 61; i++) {
        strVal = [NSString stringWithFormat:@"%d", i];
        if (i < 25) {
            [_hourArray addObject:strVal];
        }
        
        [_minuteArray addObject:strVal];
        [_secondArray addObject:strVal];
    }
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count;
    if (component == 0) {
        count = [_hourArray count];
    } else if (component == 1) {
        count = [_minuteArray count];
    } else {
        count = [_secondArray count];
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [_hourArray safeObjectAtIndex:row];
            break;
        case 1:
            return [_minuteArray safeObjectAtIndex:row];
            break;
        case 2:
            return [_secondArray safeObjectAtIndex:row];
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.selectedHour = row;
            break;
        case 1:
            self.selectedMinute = row;
            break;
        case 2:
            self.selectedSecond = row;
            break;
    }
}


#pragma mark - public
- (void)show {
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.contentView.frame;
        
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height - 260;
        
        weakSelf.contentView.frame = frame;
        
        weakSelf.backgroundView.backgroundColor = RGBA(0, 0, 0, 0.4);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.contentView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height + 260;
        
        weakSelf.contentView.frame = frame;
        
        weakSelf.backgroundView.backgroundColor = RGBA(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        
    }];
}

- (void)doneBtnClick:(id)sender {
    [self hide];
    
    if (self.doneBlock) {
        self.doneBlock(self, self.totalSeconds);
    }
}

- (void)cancelBtnClick:(id)sender {
    [self hide];
    
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

#pragma mark - get
- (NSInteger)totalSeconds {
    NSInteger hour = self.selectedHour;
    NSInteger minute = self.selectedMinute;
    NSInteger second = self.selectedSecond;
    return hour * 3600 + minute * 60 + second;
}

@end
