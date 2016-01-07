//
//  KTVideoPlayer.m
//  KTMediaPackageDemo
//
//  Created by KT on 16/1/4.
//  Copyright © 2016年 KT. All rights reserved.
//

#import "KTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface KTVideoPlayer()<UIGestureRecognizerDelegate>
{
    BOOL _isShowToolbar;
    NSDateFormatter *_dateFormatter;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *totalTime;
@property (nonatomic, assign) BOOL isInSliderChangedStated;
@property (nonatomic, assign) BOOL ignoreFirstKVO;//1s后设置slider 防止跳动
@property (nonatomic, assign) CGRect originFrame;
@end

@implementation KTVideoPlayer

#pragma mark - public method
- (instancetype)initWithFrame:(CGRect)frame
                    urlString:(NSString *)urlString
                 loadingImage:(UIImage *)loadingImage
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"KTVideoPlayer" owner:self options:nil] firstObject];
    self.frame = frame;
    self.originFrame = frame;
    self.urlString = urlString;
    if (loadingImage) {
        self.loadingImageView.image = loadingImage;
        self.loadingImageView.hidden = NO;
    }
    
    _playerLayer = (AVPlayerLayer *)self.layer;
    _playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//视频填充模式
    [_playerLayer setPlayer:self.player];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
                              
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:[UIDevice currentDevice]]; //Get the notification centre for the app
    
    return self;
}


#pragma mark - life cycle
- (void)awakeFromNib {
    [self.slider setThumbImage:[UIImage imageNamed:@"bullet_white"] forState:UIControlStateNormal];
    self.playBtn.enabled     = NO;
    self.clipsToBounds       = YES;
    self.timeLabel.text      = @"Loading...";
    _isShowToolbar           = YES;
    _isInSliderChangedStated = NO;
    _ignoreFirstKVO          = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedBackGround)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];

}

- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [self.player removeTimeObserver:self.playbackTimeObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification  object:[UIDevice currentDevice]];
    
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}


#pragma mark - Action response
- (IBAction)playAction:(UIButton *)sender {
    if (!sender.selected) {
        [self.player play];
    } else {
        [self.player pause];
    }
    sender.selected = ~sender.selected;
}

- (void)rotateAnimationDuring:(NSTimeInterval)time
                     rotation:(CGFloat)angle
                        frame:(CGRect)frame
             trailingConstant:(CGFloat)trailingValue
               bottomConstant:(CGFloat)bottomValue
                  finishBlock:(void(^)())finishblock
{
    [UIView animateWithDuration:time animations:^{
        [self setTransform:CGAffineTransformMakeRotation(angle)];
        //调整设置frame的位置，防止frame.height < constrain时候的warning
        if (angle != 0) {
            self.frame = frame;
        }

        for (NSLayoutConstraint *constrain in self.constraints) {
            if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeTrailing) {
                constrain.constant = trailingValue;
                [self setNeedsLayout];
            }
            if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeBottom) {
                constrain.constant = bottomValue;
                [self setNeedsLayout];
            }
        }
        if (angle == 0) {
            self.frame = frame;
        }
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finishblock) {
            finishblock();
        }
    }];
}

- (IBAction)fullScreenAction:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        
        [self rotateAnimationDuring:0.5
                           rotation:M_PI/2
                              frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                   trailingConstant:ScreenWidth - ScreenHeight
                     bottomConstant:-ScreenWidth + ScreenHeight
                        finishBlock:^{
             if ([self.delegate respondsToSelector:@selector(KTVideoPlayerDidRotateToLandscape:)]) {
                 [self.delegate KTVideoPlayerDidRotateToLandscape:sender.selected];
             }
         }
         ];
    }
    else {
        sender.selected = NO;
        if ([self.delegate respondsToSelector:@selector(KTVideoPlayerDidRotateToLandscape:)]) {
            [self.delegate KTVideoPlayerDidRotateToLandscape:sender.selected];
        }
        [self rotateAnimationDuring:0.5
                           rotation:0
                              frame:self.originFrame
                   trailingConstant:0
                     bottomConstant:0
                        finishBlock:nil];
    }
}


#pragma mark - TapGesture
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint gestureP = [gestureRecognizer locationInView:self];
    if (gestureP.y > self.bounds.size.height - 35 && _isShowToolbar) {
        return NO;
    } else {
        return YES;
    }
}

- (void)showToolBar:(BOOL)shown {
    if (!shown) {
        _isShowToolbar = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.transform = CGAffineTransformMakeTranslation(0, self.toolView.bounds.size.height);
        }];
    } else {
        _isShowToolbar = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}

- (void)didTappedBackGround {
    if(_isShowToolbar) {
        [self showToolBar:NO];
    } else {
        [self showToolBar:YES];
    }
}

#pragma mark - Slider
- (IBAction)videoSlierChangeValue:(id)sender {
    _isInSliderChangedStated = YES;
    if (self.playBtn.selected) {
        [self.player pause];
        self.playBtn.selected = NO;
    }
    UISlider *slider = (UISlider *)sender;
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [weakSelf.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.player play];
        }];
    }
}


- (IBAction)videoSlierChangeValueEnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        weakSelf.playBtn.selected = YES;
        [weakSelf.player play];
        weakSelf.isInSliderChangedStated = NO;
        weakSelf.ignoreFirstKVO = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.ignoreFirstKVO = NO;
        });
    }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            self.playBtn.selected = YES;
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        if (!_isInSliderChangedStated) {
            NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
            if (timeInterval > 0 ) {
                self.loadingImageView.hidden = YES;
                self.playBtn.enabled = YES;
                [self monitoringPlayback:self.playerItem];// 监听播放状态
            }
            CMTime duration = _playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            [self.progressBar setProgress:timeInterval / totalDuration animated:YES];
            if (self.playBtn.selected) {
                if (self.slider.value <= timeInterval-1.5) {
                    [self.player play];
                    [self.spinner stopAnimating];
                } else {
                    [self.player pause];
                    [self.spinner startAnimating];
                }
            }
        }
    }
}

#pragma mark - private methods
//获取视频缩略图
- (UIImage *)getImage:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

//屏幕旋转
- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    switch (o) {
        case UIDeviceOrientationPortrait:    {        // Device oriented vertically, home button on the bottom
            if ([self.delegate respondsToSelector:@selector(KTVideoPlayerDidRotateToLandscape:)]) {
                [self.delegate KTVideoPlayerDidRotateToLandscape:NO];
            }
            [self rotateAnimationDuring:0.5
                               rotation:0
                                  frame:self.originFrame
                       trailingConstant:0
                         bottomConstant:0
                            finishBlock:nil];
            break;
        }
        case UIDeviceOrientationLandscapeLeft:{      // Device oriented horizontally, home button on the right
            [self rotateAnimationDuring:0.5
                               rotation:M_PI/2
                                  frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                       trailingConstant:ScreenWidth - ScreenHeight
                         bottomConstant:-ScreenWidth + ScreenHeight
                            finishBlock:^{
                                if ([self.delegate respondsToSelector:@selector(KTVideoPlayerDidRotateToLandscape:)]) {
                                    [self.delegate KTVideoPlayerDidRotateToLandscape:YES];
                                }
                            }];
            break;
        }
        case UIDeviceOrientationLandscapeRight:  {    // Device oriented horizontally, home button on the left
            [self rotateAnimationDuring:0.5
                               rotation:M_PI/2*3
                                  frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                       trailingConstant:ScreenWidth - ScreenHeight
                         bottomConstant:-ScreenWidth + ScreenHeight
                            finishBlock:^{
                                if ([self.delegate respondsToSelector:@selector(KTVideoPlayerDidRotateToLandscape:)]) {
                                    [self.delegate KTVideoPlayerDidRotateToLandscape:YES];
                                }
                            }];
            break;
        }
        default:
            break;
    }
}

//缓存时间长度
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

//slider View
- (void)customVideoSlider:(CMTime)duration {
    self.slider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.slider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}


//play finished
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [self.player pause];
    }];
    self.playBtn.selected = NO;
}

//拖动时间
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        NSString *timeString = [weakSelf convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,weakSelf.totalTime];
        if (!weakSelf.isInSliderChangedStated && !weakSelf.ignoreFirstKVO) {
            [weakSelf.slider setValue:currentSecond animated:YES];
        }
    }];
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

#pragma mark - setter/getter
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
    }
    return _player;
}

- (AVPlayerItem *)playerItem {
    if (!_playerItem) {
        NSURL *videoUrl = [NSURL URLWithString:self.urlString];
        _playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playerItem;
}

@end
