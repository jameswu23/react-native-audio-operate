//
//  RNAudioOperate.m
//  RNAudioOperate
//
//  Created by James on 2021/10/27.
//

#import "RNAudioOperate.h"
#import <AVFoundation/AVFoundation.h>
@implementation RNAudioOperate

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(mergeAudios:(NSString *)pathStrings destnation:(NSString *)outputUrl callback:(RCTResponseSenderBlock)callback) {
  NSLog(@"pathStrings:%@",pathStrings);
  NSLog(@"outputUrl:%@",outputUrl);
  dispatch_sync(dispatch_get_main_queue(), ^{
    // NSData *turnData = [pathStrings dataUsingEncoding:NSUTF8StringEncoding];
    // NSArray *turnArray = [NSJSONSerialization JSONObjectWithData:turnData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *turnArray = [pathStrings componentsSeparatedByString:@","];
    if (turnArray.count == 0 || [outputUrl isEqualToString:@""] || outputUrl == nil) {
            return;
        }
        AVMutableComposition *composition = [AVMutableComposition composition];
//        // 设置音频合并音轨
        AVMutableCompositionTrack *compositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        // 开始时间
        CMTime beginTime = kCMTimeZero;
        NSError *error = nil;
        for (NSString *urlString in turnArray) {
          NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",urlString]];
            // 音频文件资源
            AVURLAsset *asset = [AVURLAsset assetWithURL:url];
            // 需要合并的音频文件的区间
            CMTimeRange timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
            // ofTrack 音频文件内容
            AVAssetTrack *track = [asset tracksWithMediaType:AVMediaTypeAudio].firstObject;
            //
            [compositionTrack insertTimeRange:timeRange ofTrack:track atTime:beginTime error:&error];
            if (error) {
                NSLog(@"error:%@",error);
            }

            beginTime = CMTimeAdd(beginTime, asset.duration);
        }
//
        NSURL *outputURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",outputUrl]];
        [[NSFileManager defaultManager] removeItemAtURL:outputURL error:nil];

        // 导出合并的音频
        // presetName 与 outputFileType 要对应
        AVAssetExportSession *export = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
        export.outputURL = outputURL;
        export.outputFileType = AVFileTypeAppleM4A;
        export.shouldOptimizeForNetworkUse = YES;
        [export exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    if(export.status == AVAssetExportSessionStatusCompleted) {
                        AVURLAsset *asset = [AVURLAsset assetWithURL:outputURL];
                        int64_t seconds = asset.duration.value / asset.duration.timescale;
                      callback(@[@{@"code":@"200",@"msg":@"合成成功",@"seconds":[NSString stringWithFormat:@"%lld",seconds],@"audioPath":outputUrl}]);
                    }else if(export.status == AVAssetExportSessionStatusFailed){
                      callback(@[@{@"code":@"500",@"msg":error}]);
                    }
                }
            });
        }];
  });
}

@end
