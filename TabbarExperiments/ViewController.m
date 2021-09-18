//
//  ViewController.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 17.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "ViewController.h"
#import "EMJTabbarControl.h"
#import "DVSwitch.h"
#import "EMJFilterScrollView.h"
#import "EMJIntenseView.h"
#import "CIFilterHelper.h"
#import "EmojyHelper.h"
#import "InstagramActivityIndicator.h"
#import "EMJInappPurchaseView.h"
#import "EMJButtonAnimationEffect.h"
#import "BABCropperView.h"
#import "EMJStartHelperView.h"
#import "EMJSettingsScreen.h"
#import "EMJTutorialView.h"
#import "EMJCardTutorialView.h"
#import "EMJTutorialObject.h"
#import "EmojiTextManager.h"
#import "IconColorDescription.h"
#import "UnderConstructionView.h"


#define weakify(...) \
ext_keywordify \
metamacro_foreach_cxt(ext_weakify_,, __weak, __VA_ARGS__)

static const CGFloat EMJTabBarSize = 200;//110;

@interface ViewController () <EMJFilterScrollViewDelegate, EMJIntenseViewDelegate, EMJFilterViewDelegate, EMJTabbarControlDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, EMJTutorialViewDelegate>

@property (nonatomic, strong) DVSwitch *switcher;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *descriptionSliderLabel;
@property (nonatomic, strong) UILabel *descriptionTextLabel;
@property (nonatomic, strong) UISlider *sliderView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) EMJIntenseView *intenseView;
@property (nonatomic, strong) EMJFilterScrollView *filterScrollView;
@property (nonatomic, assign) BOOL isEditMenuShown;
@property (nonatomic, assign) BOOL isAnimated;
@property (nonatomic, assign) BOOL isMagicWorks;
@property (nonatomic, strong) InstagramActivityIndicator *activityIndicator;

@property (nonatomic, assign) CGFloat filterIntensity;
@property (nonatomic, assign) FilterType filterType;

@property (nonatomic, strong) EMJInappPurchaseView *purchaseView;
@property (nonatomic, strong) EMJTabbarControl *tabBarControl;
@property (nonatomic, strong) BABCropperView *cropperView;
@property (nonatomic, strong) EMJStartHelperView *helperView;

@property (nonatomic, assign) BOOL isText;

@end

@implementation ViewController
{
    UINavigationBar *navbar;
    UIBarButtonItem *retakeButton;
    UINavigationItem *item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20 +  [UIApplication sharedApplication].keyWindow.safeAreaInsets.top, self.view.frame.size.width, 60)];
    navbar.barTintColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
    navbar.translucent = NO;
    
    UIImage *dotsImage = [UIImage imageNamed:@"share"];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:dotsImage style:UIBarButtonItemStylePlain target:self action:@selector(shareImagePressed)];
    shareButton.tintColor = [UIColor whiteColor];
    
    UIImage *retakeImage = [UIImage imageNamed:@"reloadBold"];
    retakeButton = [[UIBarButtonItem alloc] initWithImage:retakeImage style:UIBarButtonItemStylePlain target:self action:@selector(retakeButtonDidTap)];
    retakeButton.tintColor = [UIColor whiteColor];
    item = [[UINavigationItem alloc] initWithTitle:@"Эм😏джин😜тор"];
    item.rightBarButtonItem = shareButton;
    navbar.items = @[item];
    [navbar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.view addSubview:navbar];
    
    self.tabBarControl = [[EMJTabbarControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - EMJTabBarSize, self.view.frame.size.width, EMJTabBarSize)];
    self.tabBarControl.delegate = self;
    self.tabBarControl.hardCodeSize = 110;
    [self.tabBarControl updateMainButtonWithMainType:EmojiCircleButtonCameraMain];
	
    self.image = [UIImage imageNamed:@"citi2.jpg"];
	self.imageView = [[UIImageView alloc] initWithImage:self.image];
	self.imageView.frame = CGRectMake(0, CGRectGetMaxY(navbar.frame) + [EmojyHelper properValueWithDefaultValue:20], self.view.frame.size.width, self.view.frame.size.width);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
	[self.view addSubview:self.imageView];
    
    UIView *coloredView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(navbar.frame), self.view.frame.size.width, [EmojyHelper properValueWithDefaultValue:20])];
    coloredView.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:coloredView];

    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width, [EmojyHelper properValueWithDefaultValue:30])];
    self.descriptionLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:14.0]];
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    self.descriptionLabel.text = @"После магии получим:";
    [self.view addSubview:self.descriptionLabel];
    
    self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"Картинка", @"Текст"]];
    self.switcher.frame = CGRectMake([EmojyHelper properValueWithDefaultValue:25], CGRectGetMaxY(self.descriptionLabel.frame), self.view.frame.size.width - 2 * [EmojyHelper properValueWithDefaultValue:25], [EmojyHelper properValueWithDefaultValue:35]);
    self.switcher.backgroundColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
    self.switcher.sliderColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    self.switcher.labelTextColorOutsideSlider = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:self.switcher];
    self.descriptionTextLabel.hidden = YES;
    [self.view addSubview:self.descriptionTextLabel];
    
    [self.switcher setPressedHandler:^(NSUInteger index)
    {
        // TODO избавиться от Warning (weakify / strongify)
        BOOL isHidden = index;
        self.isText = index;
        self.descriptionTextLabel.hidden = !isHidden;
        self.descriptionSliderLabel.hidden = isHidden;
        self.sliderView.hidden = isHidden;
        NSLog(@"Did switch to index: %lu", (unsigned long)index);
    }];
    
    self.descriptionSliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.switcher.frame) + [EmojyHelper properValueWithDefaultValue:5], self.view.frame.size.width, [EmojyHelper properValueWithDefaultValue:30])];
    self.descriptionSliderLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:14]];
    self.descriptionSliderLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionSliderLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    self.descriptionSliderLabel.text = @"Степень детализации:";
    [self.view addSubview:self.descriptionSliderLabel];

    self.sliderView = [[UISlider alloc] initWithFrame:CGRectMake([EmojyHelper properValueWithDefaultValue:25], CGRectGetMaxY(self.descriptionSliderLabel.frame), self.view.bounds.size.width - 2 * [EmojyHelper properValueWithDefaultValue:25], [EmojyHelper properValueWithDefaultValue:20])];
    self.sliderView.tintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    [self.view addSubview:self.sliderView];
    
    // TEMP TEST
    self.filterScrollView = [[EMJFilterScrollView alloc] initWithImageForFilters:[UIImage imageNamed:@"citi2.jpg"]];
    self.filterScrollView.frame = CGRectMake(0, self.imageView.frame.size.height - self.filterScrollView.frame.size.height, self.imageView.frame.size.width, self.filterScrollView.frame.size.height);
    self.filterScrollView.alpha = 0;
    self.filterScrollView.delegate = self;
    [self.imageView addSubview:self.filterScrollView];
    
    self.intenseView = [[EMJIntenseView alloc] initWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, [EmojyHelper properValueWithDefaultValue:40])];
    self.intenseView.alpha = 0;
    self.intenseView.delegate = self;
    [self.imageView addSubview:self.intenseView];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateEditionMenu)];
    self.tapRecognizer.numberOfTouchesRequired = 1;
    self.tapRecognizer.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:self.tapRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startMagic) name:@"EMJMagic" object:nil];
    self.filterIntensity = 1;
    
    //TEMP
//    [EmojyHelper setNeedShowTutorial:YES];
    
    // NORM
    if (![EmojyHelper wasTutorialShown])
        [self addTutorialView];
    
    // TEMP
    [EmojyHelper setIsFireEnabled:YES];
    
    [self.view addSubview:self.tabBarControl];
    [self presentTutorialIfNeeded];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)animateEditionMenu
{
    if (!self.isAnimated)
    {
        self.isAnimated = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.filterScrollView.alpha = self.isEditMenuShown ? 0 : 1;
            self.intenseView.alpha = self.isEditMenuShown ? 0 : 1;
        } completion:^(BOOL finished) {
            self.isEditMenuShown = !self.isEditMenuShown;
            self.isAnimated = NO;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorMaimImageWithFilter:(FilterType)filterType
{
    self.filterType = filterType;
    self.image = [[CIFilterHelper shared] imageForFilterType:filterType withImage:self.image andIntensity:[NSNumber numberWithFloat:self.filterIntensity]];
    self.imageView.image = self.image;
}

- (void)startActivityIndicator
{
    if (!self.activityIndicator)
    {
        self.activityIndicator = [[InstagramActivityIndicator alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        self.activityIndicator.lineWidth = 3;
        self.activityIndicator.strokeColor = [EmojyHelper averageColorForImage:self.imageView.image];
        self.activityIndicator.numSegments = 15;
        self.activityIndicator.rotationDuration = 10;
        self.activityIndicator.animationDuration = 1.0;
        self.activityIndicator.center = CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height/2);
        [self.imageView addSubview:self.activityIndicator];
    }
    [self.activityIndicator startAnimating];
}

- (void)stopActivityIndicator
{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    self.activityIndicator = nil;
}

- (void)startMagic
{
    if (!self.isMagicWorks)
    {
        const CGFloat EMJAnimationOffset = 30;
        if ([EmojyHelper isButtonAnimationEnabled])
        {
            [[EMJButtonAnimationEffect new] startAnimationWithType:EMJEffectTypeStartMagic andFrame:CGRectMake(-EMJAnimationOffset, CGRectGetMinY(self.tabBarControl.frame), CGRectGetWidth(self.view.frame) + 2 * EMJAnimationOffset, CGRectGetHeight(self.tabBarControl.frame))];
        }
        self.isMagicWorks = !self.isMagicWorks;
        UIVisualEffectView *visualEffectView;
        if (![EmojyHelper isMagicEnabled])
        {
            UIVisualEffect *blurEffect;
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            visualEffectView.frame = self.imageView.bounds;
            [self.imageView addSubview:visualEffectView];
            
            [self startActivityIndicator];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            CGFloat numberOfRects = -1;
            // 12 для Plus, протестить на других
			// поменяю 12 на - 24
            CGFloat optimalNumberOfRects = self.isText ? 96 : [EmojyHelper optimalRectNumberFromSlider:self.sliderView.value];
            CGFloat minimumSize = (self.image.size.width > self.image.size.height) ? self.image.size.width : self.image.size.height;
            numberOfRects = [EmojyHelper numberOfRectsWithSize:minimumSize andOptimalNumber:optimalNumberOfRects];
            float rectSize = minimumSize/numberOfRects;
            for (float i = 0; i <= minimumSize; i = i + rectSize)
                for (float j = 0; j <= minimumSize; j = j + rectSize)
                {
                    @autoreleasepool
                    {
                        UIImage *emojiImage = [EmojyHelper emojiImageFromImage:self.image withSliderValue:self.sliderView.value anRect:CGRectMake(i, j, rectSize, rectSize) forText:self.isText];
                        self.image = [EmojyHelper drawImage:emojiImage onImage:self.image inRect:CGRectMake(i, j, rectSize, rectSize)];
                         dispatch_sync(dispatch_get_main_queue(), ^{
                             self.imageView.image = self.image;
                         });
                    };
                }
            if (self.isText)
            {
                // TODO ВОТ ТУТ НАДО РАЗВОРАЧИВАТЬ ИНВЕРТНО - СТРОКА/СТОЛБЕЦ
                NSString *invertedString = [[EmojiTextManager shared] returnFormattedString];
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = [invertedString description];
                [[EmojiTextManager shared] clearString];
            }
            self.isMagicWorks = !self.isMagicWorks;
            if (![EmojyHelper isMagicEnabled])
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self stopActivityIndicator];
                    [visualEffectView removeFromSuperview];
                });
            }
        });
    }
}

- (void)sliderValueDidChange:(CGFloat)sliderValue
{
    if (fabs(sliderValue - self.filterIntensity) > 0.1)
    {
        self.filterIntensity = sliderValue;
        if (self.filterType != EmojiFilterTypeFive)
        {
            self.image = [[CIFilterHelper shared] imageForFilterType:self.filterType withImage:self.image andIntensity:[NSNumber numberWithFloat:self.filterIntensity]];
            self.imageView.image = self.image;
        }
    }
}

- (void)sourceButtonDidTap
{
    [self showImagePicker];
}

- (void)shareButtonDidTap
{
    [self shareImagePressed];
}

- (void)inAppButtonDidTap
{
    [self showInAppWindow];
}

- (void)cameraButtonDidTap
{
    [self openCamera];
}

- (void)openCamera
{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)showImagePicker
{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];

    self.cropperView = [[BABCropperView alloc] initWithFrame:self.view.frame];
	// TODO - изначально 750
    self.cropperView.cropSize = CGSizeMake(750, 750);
    self.cropperView.cropsImageToCircle = NO;
    self.cropperView.image = image;
    [self.view addSubview:self.cropperView];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIButton *cropButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cropButton setTitle:@"Обрезать" forState:UIControlStateNormal];
    cropButton.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 80, CGRectGetWidth(self.view.frame), 80);
    [cropButton addTarget:self action:@selector(cropButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.cropperView addSubview:cropButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"Отмена" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(5, 20, 80, 40);
    [cancelButton setTitleColor:[UIColor colorWithRed:201/255.0 green:34/255.0 blue:24/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.cropperView addSubview:cancelButton];
    [self hideStartHelpViewIfNeeded];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self hideStartHelpViewIfNeeded];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideStartHelpViewIfNeeded
{
    [self.helperView removeFromSuperview];
    self.helperView = nil;
}

- (void)shareImagePressed
{
    NSArray *objectsToShare = @[self.imageView.image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeOpenInIBooks,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    [self presentViewController:activityVC animated:YES completion:nil];
}


#pragma mark - InApp presentation

- (EMJInappPurchaseView *)purchaseView
{
    if (!_purchaseView)
    {
        _purchaseView = [[EMJInappPurchaseView alloc] initWithFrame:CGRectMake(20, 45, self.view.frame.size.width - 20*2, self.view.frame.size.height - 50*2)];
        // some other settings
    }
    _purchaseView.frame = CGRectMake(20, 45, self.view.frame.size.width - 20*2, self.view.frame.size.height - 50*2);
    return _purchaseView;
}

- (void)showInAppWindow
{
    UnderConstructionView *constructionView = [UnderConstructionView new];
    [constructionView presentOnWindow];
    // Экран покупки
    //[self.purchaseView presentOnWindow];
}


#pragma mark - Crop representation

- (void)cropButtonPressed
{
    __weak typeof(self)weakSelf = self;

    [self.cropperView renderCroppedImage:^(UIImage *croppedImage, CGRect cropRect){
        
        [weakSelf displayCroppedImage:croppedImage];
    }];
}

- (void)cancelButtonPressed
{
    [self hideCropView];
}

- (void)displayCroppedImage:(UIImage *)croppedImage {
    // TODO вот тут размер выставляется, пока умножаем на 4 вместо 2х
    croppedImage = [EmojyHelper imageWithImage:croppedImage scaledToWidth:self.imageView.frame.size.width * 4];
    self.image = croppedImage;
    self.imageView.image = croppedImage;
    [self hideCropView];
    
    [self.tabBarControl updateMainButtonWithMainType:EmojiCircleButtonMagicMain];
    
    item.leftBarButtonItem = retakeButton;
    navbar.items = @[item];
}

- (void)hideCropView
{
    [UIView animateWithDuration:0.4 animations:^{
        self.cropperView.center = CGPointMake(self.cropperView.center.x, self.cropperView.center.y + CGRectGetHeight(self.view.frame));
    } completion:^(BOOL finished) {
        [self.cropperView removeFromSuperview];
    }];
}

- (void)retakeButtonDidTap
{
    [self.tabBarControl presentSourceTypeWindow];
}

- (void)openSettings
{
    EMJSettingsScreen *settingsScreen = [[EMJSettingsScreen alloc] initWithFrame:self.view.frame];
    [self.view addSubview:settingsScreen];
}

- (void)presentTutorialIfNeeded
{
    if (![EmojyHelper wasTutorialShown])
    {
        /* Начальные настройки */
        [EmojyHelper setIsMagicEnabled:YES];
        [EmojyHelper setIsButtonAnimationEnabled:YES];
        [EmojyHelper setNeedShowTutorial:NO];
        
        /* Туториал */
        EMJTutorialObject *firsrTutorialObject = [EMJTutorialObject initWithTitle:@"Добро пожаловать в эмоджинатор!" description:@"Превращайте ваши фотографии в мозайку эмодзи!" andImageName:@"magicWand"];
        EMJCardTutorialView *firstCardTutorialView = [[EMJCardTutorialView alloc] initWithTutorialObject:firsrTutorialObject];
        EMJTutorialObject *secondTutorialObject = [EMJTutorialObject initWithTitle:@"Обрабатывайте фото до и после эмоджинации" description:@"Используйте встроенные фильтры, чтобы добавить больше эмоций в ваши творения!" andImageName:@"galeryIcn"];
        EMJCardTutorialView *secondTutorialView = [[EMJCardTutorialView alloc] initWithTutorialObject:secondTutorialObject];
        EMJTutorialObject *thirdTutorialObject = [EMJTutorialObject initWithTitle:@"Делитесь эмодзи-шедеврами!" description:@"Сохраняйте и отправляйте полученные результаты в формате графики или эмодзи-текста!" andImageName:@"share"];
        EMJCardTutorialView *thirdTutorialView = [[EMJCardTutorialView alloc] initWithTutorialObject:thirdTutorialObject];
        EMJTutorialView *tutorialView = [[EMJTutorialView alloc] initWithCardTutorialViews:@[firstCardTutorialView, secondTutorialView, thirdTutorialView]];
        tutorialView.backgroundImage = [UIImage imageNamed:@"emojiBack"];
        tutorialView.tutorialDelegate = self;
        
        [self.view addSubview:tutorialView];
    }
}

- (void)addTutorialView
{
    // Показывть только при первом запуске
    self.helperView = [[EMJStartHelperView alloc] initWithFrame:self.imageView.frame];
    [self.view addSubview:self.helperView];
}

// Properties

-(UILabel *)descriptionTextLabel
{
    if (!_descriptionTextLabel)
    {
        _descriptionTextLabel = [[UILabel alloc] initWithFrame:CGRectMake([EmojyHelper properValueWithDefaultValue:25], CGRectGetMaxY(self.switcher.frame) + [EmojyHelper properValueWithDefaultValue:5], self.view.frame.size.width - [EmojyHelper properValueWithDefaultValue:25] * 2, [EmojyHelper properValueWithDefaultValue:55])];
        _descriptionTextLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionTextLabel.numberOfLines = 0;
        _descriptionTextLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:10]];
        _descriptionTextLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        _descriptionTextLabel.text = @"Для отображения в виде текста подходят контрастные, лишенные большого количества деталей изображения. Текст автоматически скопируется в буфер обмена после эмоджинации.";
    }
    return _descriptionTextLabel;
}

- (void)copyEmodjiText
{
    
}

@end
