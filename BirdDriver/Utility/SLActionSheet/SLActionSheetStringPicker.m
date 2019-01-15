//
//  SLActionSheetStringPicker.m
//  SmartLife
//
//  Created by han on 2017/3/17.
//
//

#import "SLActionSheetStringPicker.h"

#define SL_ACTION_SHEET_BTN_HEIGHT 50.0f
@interface SLActionSheetStringPicker()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *cancelText;

@property (nonatomic, copy) clickedIndexBlock block;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSMutableArray *otherButtons;

@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, assign) NSInteger buttonCount;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@end

@implementation SLActionSheetStringPicker

- (instancetype)initWithTitle:(NSString *)title clickedAtIndex:(clickedIndexBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    self = [super init];
    if (self) {
        self.titleText = [title copy];
        self.cancelText = [cancelButtonTitle copy];
        self.block = block;
        self.otherButtons = [[NSMutableArray alloc] initWithArray:otherButtonTitles];
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
    
    
    // 初始化TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.tableViewHeight) style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_tableView];
    
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
}

#pragma mark - Action
- (void)show {
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.tableView.frame;
        
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height - self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        
        weakSelf.backgroundView.backgroundColor = RGBA(0, 0, 0, 0.4);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.tableView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height + self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        
        weakSelf.backgroundView.backgroundColor = RGBA(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        
    }];
}


#pragma mark - UITableViewDelegate/UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.cancelText.length > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return self.otherButtons.count;
    }
    if(section == 1 && self.cancelText.length > 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"SLActionsheetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identify];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.layer.masksToBounds = YES;
        
        // 加上分割线
        UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor hexChangeFloat:__kSL_Line_01]]];
        sepLine.frame = CGRectMake(0, SL_ACTION_SHEET_BTN_HEIGHT - 0.5f, [UIScreen mainScreen].bounds.size.width, 0.5f);
        [sepLine setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [cell addSubview:sepLine];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    if(indexPath.section == 0){
        [cell.textLabel setTextColor:[UIColor hexChangeFloat:__kSL_Black_01]];
        [cell.textLabel setText:self.otherButtons[indexPath.row]];
    }
    if(indexPath.section == 1){
        [cell.textLabel setTextColor:[UIColor hexChangeFloat:__kSL_Black_03]];
        [cell.textLabel setText:self.cancelText];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SL_ACTION_SHEET_BTN_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 && self.titleText.length > 0) {
        return SL_ACTION_SHEET_BTN_HEIGHT;
    }
    if(section == 1 && self.cancelText.length > 0) {
        return 0.3f;
    }
    return 0.0f;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0 && self.titleText.length > 0) {
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:15.0f]];
        [label setText:self.titleText];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [label setAdjustsFontSizeToFitWidth:YES];
        UIImageView *sepLine = [[UIImageView alloc] initWithImage:[self imageWithUIColor:[UIColor hexChangeFloat:__kSL_Line_01]]];
        sepLine.frame = CGRectMake(0, SL_ACTION_SHEET_BTN_HEIGHT - 0.5f, self.tableView.bounds.size.width, 0.5f);
        [label addSubview:sepLine];
        return label;
    }
    
    if(section == 1 && self.cancelText.length > 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor hexChangeFloat:__kSL_Line_01];
        return view;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Block方式返回结果
    if(self.block && indexPath.section == 0) {
        self.block(indexPath.row);
        
    }
    [self hide];
    
}

#pragma mark - get
- (CGFloat)tableViewHeight {
    return self.buttonCount * SL_ACTION_SHEET_BTN_HEIGHT;
}

- (NSInteger)buttonCount {
    NSInteger count = 0;
    
    if(self.titleText.length > 0) {
        count += 1;
    }
    
    if(self.cancelText.length > 0) {
        count += 1;
    }
    
    count += self.otherButtons.count;
    
    return count;
}

-(UIImage *)imageWithUIColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
