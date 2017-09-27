//
//  RecordViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "RecordViewController.h"
#import "MyLabel.h"
#import "MyTextField.h"
#import "RecordViewModel.h"
#import "WSDatePickerView.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordViewController ()<SFSpeechRecognizerDelegate>
@property(nonatomic,strong) MyTextField *taskContent;
@property(nonatomic,strong) MyTextField *taskPlace;
@property(nonatomic,strong) MyLabel *taskTime;
@property(nonatomic,strong) RecordViewModel *rvm;
@property(nonatomic,strong) UILabel *tipTextLabel;
@property(nonatomic,strong) UIButton *recordButton;

@property(nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
@property(nonatomic,strong) AVAudioEngine *audioEngine;
@property(nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
@property(nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupFrame];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    weakSelf.recordButton.enabled = NO;
                    weakSelf.tipTextLabel.text = @"语音识别未授权";
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    weakSelf.recordButton.enabled = NO;
                    weakSelf.tipTextLabel.text = @"用户未授权使用语音识别";
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    weakSelf.recordButton.enabled = NO;
                    weakSelf.tipTextLabel.text = @"语音识别在这台设备上受到限制";
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    weakSelf.recordButton.enabled = YES;
                    weakSelf.tipTextLabel.text = @"开始录入语音";
                    break;
                default:
                    break;
            }
        });
    }];
}

- (void)choiceDate{
    NSLog(@"choickData");
    WSDatePickerView *picker = [[WSDatePickerView alloc] initWithCompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSMutableString *newDate = [date mutableCopy];
        [newDate appendString:@":00"];
        self.taskTime.text = newDate;
    }];
    [picker show];
}

- (void)setupFrame{
    __weak typeof(self) weakSelf = self;
    
    UIView *navView = [UIView new];
    navView.backgroundColor = [UIColor redColor];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(@64);
        make.left.equalTo(weakSelf.view);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancelBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(navView).with.offset(20);
        make.left.equalTo(navView);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"创建任务";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(cancelBtn);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn addTarget:self action:@selector(sureBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(navView).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(0);
    }];

    //任务内容
    UIImageView *taskContentIcon  = [UIImageView new];
    taskContentIcon.image = [UIImage imageNamed:@"taskContent"];
    [self.view addSubview:taskContentIcon];
    [taskContentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(cancelBtn.mas_bottom).with.offset(50);
    }];
    
    MyLabel *taskContentLabel = [MyLabel new];
    taskContentLabel.text = @"内容";
    [self.view addSubview:taskContentLabel];
    [taskContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskContentIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskContentIcon);
    }];
    
    MyTextField *taskContent = [MyTextField new];
    [self.view addSubview:taskContent];
    [taskContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskContentIcon);
        make.left.equalTo(taskContentLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    self.taskContent = taskContent;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskContentIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    //任务地点
    UIImageView *taskPlaceIcon = [UIImageView new];
    taskPlaceIcon.image = [UIImage imageNamed:@"taskPlace"];
    [self.view addSubview:taskPlaceIcon];
    [taskPlaceIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(taskContentIcon);
        make.top.equalTo(taskContentIcon.mas_bottom).with.offset(60);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskPlaceIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    MyLabel *taskPlaceLabel = [MyLabel new];
    taskPlaceLabel.text = @"地点";
    [self.view addSubview:taskPlaceLabel];
    [taskPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskPlaceIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskPlaceIcon);
    }];
    
    MyTextField *placeF = [MyTextField new];
    [self.view addSubview:placeF];
    [placeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskPlaceIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskPlaceLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.taskPlace = placeF;
    
    //任务时间
    UIImageView *taskTimeIcon = [UIImageView new];
    taskTimeIcon.image = [UIImage imageNamed:@"startTime"];
    [self.view addSubview:taskTimeIcon];
    [taskTimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(taskContentIcon);
        make.top.equalTo(taskPlaceIcon.mas_bottom).with.offset(60);
    }];
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    MyLabel *taskTimeLabel = [MyLabel new];
    taskTimeLabel.text = @"时间";
    [self.view addSubview:taskTimeLabel];
    [taskTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskTimeIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskTimeIcon);
    }];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choiceDate)];
    MyLabel *timeF = [MyLabel new];
   
    timeF.userInteractionEnabled = YES;
    timeF.text = @"请选择日期";
    [timeF addGestureRecognizer:gr];
    [self.view addSubview:timeF];
    [timeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskTimeIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskTimeLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.taskTime = timeF;
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recordBtn.layer.cornerRadius = 30;
    [recordBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [recordBtn setImage:[UIImage imageNamed:@"recording"] forState:UIControlStateSelected];
    [recordBtn addTarget:self action:@selector(recordBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(60);
    }];
    self.recordButton = recordBtn;
    
    UILabel *tipLabel  = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.text = @"请录音";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(recordBtn);
        make.top.equalTo(recordBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    self.tipTextLabel = tipLabel;
}

- (void)recordBtn_click:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        if (_recognitionRequest) {
            [_recognitionRequest endAudio];
        }
        self.recordButton.enabled = NO;
        self.tipTextLabel.text = @"正在停止";
    }else{
        [self startRecording];
        self.tipTextLabel.text = @"结束";
    }
}

- (void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
            strongSelf.taskContent.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            strongSelf.recognitionTask = nil;
            strongSelf.recognitionRequest = nil;
            strongSelf.recordButton.enabled = YES;
            strongSelf.tipTextLabel.text = @"开始";
        }
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.recognitionRequest) {
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.tipTextLabel.text = @"正在录入";
}

#pragma mark - lazyload
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}

- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

- (void)cancelBtn_click{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        self.recordButton.enabled = YES;
        self.tipTextLabel.text = @"开始";
    }else{
        self.recordButton.enabled = NO;
        self.tipTextLabel.text = @"语音识别不可用";
    }
}

- (void)sureBtn_click{
    NSString *content = self.taskContent.text;
    NSString *place = self.taskPlace.text;
    NSString *time = self.taskTime.text;
    __weak typeof(self) weakSelf = self;
    if(content.length>0&&place.length>0&&![time isEqualToString:@"请选择日期"]){
        [self.rvm addTaskWithContent:content place:place time:time completeHandle:^(BOOL isSuccess) {
            
            AlertHelper *alert = [AlertHelper shareHelper];
            if (isSuccess) {
                [alert alertWithTitle:@"添加成功" message:@"记得按时完成啊" viewController:weakSelf];
                [alert setDefaultBtnWithTitle:@"OK" handlerBlock:^{

                    weakSelf.taskContent.text = @"";
                    weakSelf.taskTime.text = @"请选择日期";
                    weakSelf.taskPlace.text = @"";
                }];
            }else{
                [alert alertWithTitle:@"添加失败" message:@"哪里出问题了呢！" viewController:weakSelf];
                [alert setCancelBtnWithTitle:@"取消" handlerBlock:^{
                    
                }];
            }
            
            [alert show];
        }];
    }else{
        AlertHelper *alert = [AlertHelper shareHelper];
        [alert alertWithTitle:@"提示" message:@"请将信息补充完整！！！" viewController:self];
        [alert setDefaultBtnWithTitle:@"继续补充" handlerBlock:^{
            
        }];
        [alert show];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (RecordViewModel *)rvm{
    if (!_rvm) {
        _rvm = [RecordViewModel new];
    }
    return _rvm;
}

@end
