//
//  NSObject+AsrManager.m
//  Runner
//
//  Created by Morimatsu_mac_2015 on 7/28/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AsrManager.h"
#import "BDSASRParameters.h"
#import "BDSASRDefines.h"
#import "BDSEventManager.h"

const NSString* API_KEY = @"My3eUqlXXehleKokh0S38P9f";
const NSString* SECRET_KEY = @"TZMSHKGqNs2WW0IDEmpXTgGOtxGaLVayFT";
const NSString* APP_ID = @"15519362";

@interface AsrManager () <BDSClientASRDelegate>
@property (strong, nonatomic) BDSEventManager *asrEventManager;
@property (nonatomic,copy)AsrCallback asrSuccess;
@property (nonatomic,copy)AsrCallback asrFailure;

@end

@implementation AsrManager
+(instancetype)initWith:(AsrCallback)success failure:
    (AsrCallback)failure{
    AsrManager*asrManager =[AsrManager new];
    asrManager.asrFailure=failure;
    asrManager.asrSuccess = success;
    return asrManager;
}
- (instancetype)init {
    if (self = [super init]) {
        self.asrEventManager = [BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
        [self configVoiceRecognitionClient];
    }
    return self;
}

- (void)start {
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_NEED_CACHE_AUDIO];
    [self.asrEventManager setDelegate:self];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
}

- (void)stop {
    [self.asrEventManager sendCommand:BDS_ASR_CMD_STOP];
}

- (void)cancel {
    [self.asrEventManager sendCommand:BDS_ASR_CMD_CANCEL];
}

- (void)configVoiceRecognitionClient {
    //设置DEBUG_LOG的级别
    [self.asrEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    //配置API_KEY 和 SECRET_KEY 和 APP_ID
    [self.asrEventManager setParameter:@[API_KEY, SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
    [self.asrEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    //配置端点检测（二选一）
    [self configModelVAD];
    //    [self configDNNMFE];

    //    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
    // ---- 语义与标点 -----
    //    [self enableNLU];
    //    [self enablePunctuation];
    // ------------------------

    //---- 语音自训练平台 ----
    //    [self configSmartAsr];
}


- (void) enableNLU {
    // ---- 开启语义理解 -----
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_NLU];
    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
}

- (void) enablePunctuation {
    // ---- 开启标点输出 -----
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_DISABLE_PUNCTUATION];
    // 普通话标点
    //    [self.asrEventManager setParameter:@"1537" forKey:BDS_ASR_PRODUCT_ID];
    // 英文标点
    [self.asrEventManager setParameter:@"1737" forKey:BDS_ASR_PRODUCT_ID];

}


- (void)configModelVAD {
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    [self.asrEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
}

#pragma mark - MVoiceRecognitionClientDelegate

- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj {
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData: {

            break;
        }

        case EVoiceRecognitionClientWorkStatusStartWorkIng: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: {
            // 语音识别成功服务器返回结果
            if ([aObj isKindOfClass:[NSDictionary class]]) {
                NSString *result = aObj[@"results_recognition"][0];
                if (self.asrSuccess) {
                    self.asrSuccess(result);
                }
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
            // 识别遇到错误
            if (self.asrFailure) {
                self.asrFailure([((NSString *)aObj) description]);
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {

            break;
        }
        default:
            break;
    }
}

@end

