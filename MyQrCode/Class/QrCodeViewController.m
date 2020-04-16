//
//  QrCodeViewController.m
//  MyQrCode
//
//  Created by Zhang on 2020/4/16.
//  Copyright © 2020 June. All rights reserved.
//

#import "QrCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QrCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // addInput
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    // addOutput
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }
    //
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    if (metadataObject) {
        //
        [_session stopRunning];
        //
        __weak typeof(self) weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            !weakSelf.qrCodeBlock ? : weakSelf.qrCodeBlock(metadataObject.stringValue);
        }];
    }
}

@end
