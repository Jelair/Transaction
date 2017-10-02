//
//  SettingViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewModel.h"

@interface SettingViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
}
@property (nonatomic,strong) UITextField *tel;
@property (nonatomic,strong) UILabel *genderLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *chBtn;
@property (nonatomic,strong) SettingViewModel *svm;
@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) AlertHelper *helper;
@property (nonatomic,strong) NSString *wPassword;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFrame];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"修改密码" style:UIBarButtonItemStylePlain target:self action:@selector(changePassword)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [self setContent];
}

- (SettingViewModel *)svm{
    if (!_svm) {
        _svm = [SettingViewModel new];
    }
    return _svm;
}

- (void)changePassword{
    _helper = [AlertHelper shareHelper];
    __weak typeof(self) weakSelf  = self;
    [_helper alertWithTitle:@"修改密码" message:@"请输入新密码" viewController:self];
    [_helper setCancelBtnWithTitle:@"不改了" handlerBlock:^{
        
    }];
    [_helper setDefaultBtnWithTitle:@"确定修改" handlerBlock:^{

        NSString *newPassword = weakSelf.helper.alert.textFields.lastObject.text;
        if (newPassword.length>6) {
            [weakSelf.svm changePasswordWith:newPassword complete:^(BOOL isSuccess) {
                
            }];
        }
        
    }];
    [_helper addTextFieldWithBlock:^(NSString *textString) {
        weakSelf.wPassword = textString;
        NSLog(@"%@",textString);
    }];
    [_helper show];
}

- (void)iconBtn_click{
    [self alterHeadPortrait];
}

//保存图片
-(void)saveImageDocuments:(UIImage *)image{
    
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    
    //拿到图片
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/myimages%d",userId]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    [self.svm changeUserIconWith:imagePath complete:nil];
}
// 读取并存贮到相册
-(UIImage *)getDocumentImage{
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    // 读取沙盒路径图片
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/myimages%d",NSHomeDirectory(),userId];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    // 图片保存相册
    UIImageWriteToSavedPhotosAlbum(imgFromUrl3, self, nil, nil);
    return imgFromUrl3;
}

//  方法：alterHeadPortrait
-(void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
   // [self.iconBtn setImage:newPhoto forState:UIControlStateNormal];
    [self.iconBtn setBackgroundImage:newPhoto forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logoutBtn_click{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)telFieldChange{
    [self.chBtn setHidden:NO];
}

- (void)changeTel{
    [self.chBtn setHidden:YES];
    NSString *newTel = self.tel.text;
    [self.svm changeTelWith:newTel complete:^(BOOL isSuccess) {
        AlertHelper *alert = [AlertHelper shareHelper];
        if (isSuccess) {
            [alert alertWithTitle:@"提示" message:@"修改成功" viewController:self];
        }else{
            [alert alertWithTitle:@"提示" message:@"修改失败" viewController:self];
        }
        [alert setDefaultBtnWithTitle:@"确定" handlerBlock:^{
            
        }];
        [alert show];
    }];
}

- (void)setContent{
    NSDictionary *dic = [[CurrentUserInfo defaultUserInfo] getUserInfo];
    self.nameLabel.text = dic[@"userName"];
    self.tel.text = dic[@"userTel"];
    self.genderLabel.text = [dic[@"userGender"] intValue]==0?@"女":@"男";
    self.ageLabel.text = [NSString stringWithFormat:@"%@",dic[@"userAge"]];
    UIImage *image = [self getDocumentImage];
    if (image == nil) {
        image = [UIImage imageNamed:@"userIcon"];
    }
    //[self.iconBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setupFrame{
    __weak typeof (self) weakSelf = self;
    
    //上传头像
    UIButton *iconBtn = [UIButton new];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"userIcon"] forState:UIControlStateNormal];
    iconBtn.layer.borderWidth = 1;
    iconBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    iconBtn.layer.cornerRadius = 45;
    iconBtn.clipsToBounds = YES;
    [iconBtn addTarget:self action:@selector(iconBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconBtn];
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(90);
    }];
    self.iconBtn = iconBtn;
    
    //用户名
    UILabel *iconLabel = [UILabel new];
    iconLabel.text = @"";
    iconLabel.textColor = [UIColor darkGrayColor];
    iconLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:iconLabel];
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconBtn);
        make.top.equalTo(iconBtn.mas_bottom).with.offset(20);
    }];
    self.nameLabel = iconLabel;
    
    //性别图标
    UIImageView *genderIcon = [UIImageView new];
    genderIcon.image = [UIImage imageNamed:@"gender"];
    [self.view addSubview:genderIcon];
    [genderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(iconLabel.mas_bottom).with.offset(30);
    }];
    
    //
    UILabel *genderLabel = [UILabel new];
    genderLabel.text = @"性别";
    genderLabel.textColor = [UIColor darkGrayColor];
    genderLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:genderLabel];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(genderIcon);
        make.left.equalTo(genderIcon.mas_right).with.offset(5);
        make.width.mas_equalTo(@50);
    }];
    
    //
    UILabel *genderContent = [UILabel new];
    genderContent.text = @"";
    genderContent.textColor = [UIColor darkGrayColor];
    genderContent.textAlignment = NSTextAlignmentRight;
    genderContent.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:genderContent];
    [genderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(genderIcon);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.genderLabel = genderContent;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.top.equalTo(genderIcon.mas_bottom).with.offset(5);
    }];
    
    //年龄
    UIImageView *ageIcon = [UIImageView new];
    ageIcon.image = [UIImage imageNamed:@"age"];
    [self.view addSubview:ageIcon];
    [ageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(lineView.mas_bottom).with.offset(10);
    }];
    
    //
    UILabel *ageLabel = [UILabel new];
    ageLabel.text = @"年龄";
    ageLabel.font = [UIFont systemFontOfSize:15];
    ageLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:ageLabel];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ageIcon);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(ageIcon.mas_right).with.offset(5);
    }];
    
    //
    UILabel *ageContent = [UILabel new];
    ageContent.textColor = [UIColor darkGrayColor];
    ageContent.font = [UIFont systemFontOfSize:15];
    ageContent.text = @"";
    ageContent.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:ageContent];
    [ageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ageIcon);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.ageLabel = ageContent;
    
    //
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ageIcon.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    //电话
    UIImageView *telIcon = [UIImageView new];
    telIcon.image = [UIImage imageNamed:@"tel"];
    [self.view addSubview:telIcon];
    [telIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
    }];
    
    //
    UILabel *telLabel = [UILabel new];
    telLabel.textColor = [UIColor darkGrayColor];
    telLabel.font = [UIFont systemFontOfSize:15];
    telLabel.text = @"电话";
    [self.view addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telIcon);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(telIcon.mas_right).with.offset(5);
    }];
    
    //
    UITextField *telContent = [UITextField new];
    telContent.textColor = [UIColor darkGrayColor];
    telContent.font = [UIFont systemFontOfSize:15];
    telContent.text = @"";
    telContent.textAlignment = NSTextAlignmentRight;
    [telContent addTarget:self action:@selector(telFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:telContent];
    [telContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telIcon);
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.tel = telContent;
    
    //
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telIcon.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    //修改电话号码
    UIButton *changeTel = [UIButton buttonWithType:UIButtonTypeCustom];
    changeTel.layer.cornerRadius = 5;
    [changeTel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    changeTel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    changeTel.layer.borderWidth = 1;
    [changeTel setTitle:@"修改电话" forState:UIControlStateNormal];
    changeTel.titleLabel.font = [UIFont systemFontOfSize:15];
    [changeTel addTarget:self action:@selector(changeTel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeTel];
    [changeTel setHidden:YES];
    [changeTel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.top.equalTo(lineView3.mas_bottom).with.offset(50);
    }];
    self.chBtn = changeTel;
    
    //登出
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.layer.cornerRadius = 5;
    [logoutBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    logoutBtn.layer.borderWidth = 1;
    logoutBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [logoutBtn setTitle:@"登出" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.top.equalTo(changeTel.mas_bottom).with.offset(50);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
