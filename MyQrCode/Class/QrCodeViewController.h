//
//  QrCodeViewController.h
//  MyQrCode
//
//  Created by Zhang on 2020/4/16.
//  Copyright © 2020 June. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QrCodeViewController : UIViewController

@property (nonatomic, copy) void(^qrCodeBlock)(NSString *codeString);

@end

NS_ASSUME_NONNULL_END
