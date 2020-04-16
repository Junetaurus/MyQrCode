//
//  HomeViewController.m
//  MyQrCode
//
//  Created by Zhang on 2020/4/16.
//  Copyright © 2020 June. All rights reserved.
//

#import "HomeViewController.h"
#import "QrCodeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIButton *replicaBtn;
@property (nonatomic, strong) UIButton *openBtn;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) QrCodeViewController *qrCodeVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat btnW = 150;
    CGFloat btnH = 40;
    CGFloat btnX = (self.view.bounds.size.width - btnW)/2;
    //
    _scanBtn = [self creatBtnWithTitle:@"扫描二维码"];
    _scanBtn.frame = CGRectMake(btnX, 100, btnW, btnH);
    //
    _replicaBtn = [self creatBtnWithTitle:@"复制到剪切板"];
    _replicaBtn.frame = CGRectMake(btnX, 170, btnW, btnH);
    //
    _openBtn = [self creatBtnWithTitle:@"浏览器打开"];
    _openBtn.frame = CGRectMake(btnX, 240, btnW, btnH);
    //
    _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(btnH, 330, self.view.bounds.size.width - 2*btnH, 0)];
    _resultLabel.numberOfLines = 0;
    _resultLabel.textColor = [UIColor blueColor];
    _resultLabel.font = [UIFont systemFontOfSize:15];
    _resultLabel.layer.borderColor = [UIColor blueColor].CGColor;
    _resultLabel.layer.borderWidth = .5;
    [self.view addSubview:_resultLabel];
}

- (UIButton *)creatBtnWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = .5;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

- (void)btnClick:(UIButton *)btn {
    if (btn == _scanBtn) {
        [self presentViewController:self.qrCodeVC animated:YES completion:nil];
    }
    if (!_resultLabel.text) return;
    if (btn == _replicaBtn) {
        UIPasteboard.generalPasteboard.string = _resultLabel.text;
    }
    if (btn == _openBtn) {
        NSURL *url = [NSURL URLWithString:_resultLabel.text];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
}

- (QrCodeViewController *)qrCodeVC {
    if (!_qrCodeVC) {
        _qrCodeVC = [[QrCodeViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        _qrCodeVC.qrCodeBlock = ^(NSString * _Nonnull codeString) {
            weakSelf.resultLabel.text = codeString;
            CGFloat resultLabelX = weakSelf.resultLabel.frame.origin.x;
            CGFloat resultLabelY = weakSelf.resultLabel.frame.origin.y;
            CGFloat resultLabelW = weakSelf.resultLabel.frame.size.width;
            CGFloat resultLabelH = [weakSelf.resultLabel sizeThatFits:CGSizeMake(resultLabelW, CGFLOAT_MAX)].height;
            weakSelf.resultLabel.frame = CGRectMake(resultLabelX, resultLabelY, resultLabelW, resultLabelH);
        };
    }
    return _qrCodeVC;
}

@end
