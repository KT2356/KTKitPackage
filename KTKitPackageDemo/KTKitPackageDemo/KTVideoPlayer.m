//
//  KTVideoPlayer.m
//  KTMediaPackageDemo
//
//  Created by KT on 16/1/4.
//  Copyright © 2016年 KT. All rights reserved.
//

#import "KTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface KTVideoPlayer()
{
    BOOL _played;
    BOOL _isShowToolbar;
    NSDateFormatter *_dateFormatter;
}

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *totalTime;
@end

@implementation KTVideoPlayer

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString {
    self = [[[NSBundle mainBundle] loadNibNamed:@"KTVideoPlayer" owner:self options:nil] firstObject];
    self.frame = frame;
    self.urlString = urlString;
    
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.layer;
    [playerLayer setPlayer:self.player];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    return self;
}

- (void)awakeFromNib {
    [self.slider setThumbImage:[UIImage imageNamed:@"bullet_white"] forState:UIControlStateNormal];
    self.playBtn.enabled = NO;
    self.clipsToBounds = YES;
} 

- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.player removeTimeObserver:self.playbackTimeObserver];
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}


#pragma mark - Action response
- (IBAction)playAction:(UIButton *)sender {
    if (!_played) {
        [self.player play];
    } else {
        [self.player pause];
    }
    _played = !_played;
}

- (IBAction)fullScreenAction:(UIButton *)sender {
    
}

- (IBAction)didtappedBackground:(UITapGestureRecognizer *)sender {
    _isShowToolbar = ~_isShowToolbar;
    if(_isShowToolbar) {
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.transform = CGAffineTransformMakeTranslation(0, self.toolView.bounds.size.height);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.toolView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.playBtn.enabled = YES;
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback:self.playerItem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.progressBar setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)customVideoSlider:(CMTime)duration {
    self.slider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.slider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}


- (IBAction)videoSlierChangeValue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value change:%f",slider.value);
    
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.player play];
        }];
    }
}

- (IBAction)videoSlierChangeValueEnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.player play];
        //[weakSelf.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
    }];
}

- (void)updateVideoSlider:(CGFloat)currentSecond {
    [self.slider setValue:currentSecond animated:YES];
}


- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.slider setValue:0.0 animated:YES];
        //[weakSelf.stateButton setTitle:@"Play" forState:UIControlStateNormal];
    }];
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.slider setValue:currentSecond animated:YES];
        NSString *timeString = [weakSelf convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,weakSelf.totalTime];
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
