//
//  SLActionSheetDatePicker.m
//  SmartLife
//
//  Created by han on 2017/3/17.
//
//

#import "SLActionSheetDatePicker.h"

@interface SLActionSheetDatePicker()

@property (nonatomic, copy) actionDateDoneBlock doneBlock;
@property (nonatomic, copy) actionDateCancelBlock cancelBlock;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *actionView;
@property (nonatomic, strong) UIButton *doneBtn, *cancelBtn;
@end
@implementation SLActionSheetDatePicker

- (instancetype)initWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate doneBlock:(actionDateDoneBlock)doneBlock cancelBlock:(actionDateCancelBlock)cancelBlock {
    self = [super init];
    if (self) {
        self.doneBlock = doneBlock;
        self.cancelBlock = cancelBlock;
        self.title = title;
        self.datePickerMode = datePickerMode;
        self.selectedDate = selectedDate;
        [self initUI];
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
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = self.datePickerMode;
    if (self.selectedDate) {
        [_datePicker setDate:self.selectedDate];
    }
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_datePicker];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.actionView);
    }];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.actionView);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.size.width - 16);
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(44);
        make.height.mas_equalTo(216);
    }];
    
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
}

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
        self.doneBlock(self, self.datePicker.date);
    }
}

- (void)cancelBtnClick:(id)sender {
    [self hide];
    
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = _maximumDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = _minimumDate;
}
@end
