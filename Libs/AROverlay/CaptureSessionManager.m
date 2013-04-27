#import "CaptureSessionManager.h"


@implementation CaptureSessionManager


#pragma mark Capture Session Configuration

- (id)init {
	if ((self = [super init])) {
		[self setCaptureSession:[[AVCaptureSession alloc] init]];
	}
	return self;
}

- (void)addVideoPreviewLayer {
	_previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
	[_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  
}

- (void)addVideoInput {
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];	
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([_captureSession canAddInput:videoIn])
				[_captureSession addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");		
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}

- (void)dealloc {

	[_captureSession stopRunning];

	_previewLayer = nil;
	_captureSession = nil;

}

@end
