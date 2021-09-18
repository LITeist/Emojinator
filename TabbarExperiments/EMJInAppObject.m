//
//  EMJInAppObject.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 01.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJInAppObject.h"


@implementation EMJInAppObject

- (instancetype)initWithInAppType:(InAppType)inAppType
{
    self = [super init];
    if (self)
    {
        _inAppType = inAppType;
    }
    return self;
}

- (NSString *)inAppTitle
{
    NSString *titleToReturn = NSLocalizedString(@"No Title", nil);
    switch (self.inAppType)
    {
        case EMJInAppTypeAdds:
        {
            titleToReturn = NSLocalizedString(@"Отключение рекламы,\nфинансовые эмодзи!", nil);
        }
            break;
        case EMJInAppTypeSpace:
        {
            titleToReturn = NSLocalizedString(@"Детка, ты\nпросто космос!", nil);
        }
            break;
        case EMJInAppObjectFire:
        {
            titleToReturn = NSLocalizedString(@"Огонь!", nil);
        }
            break;
        case EMJInAppTypeAnimals:
        {
            titleToReturn = NSLocalizedString(@"Выпусти запертое\nвнутри животное!", nil);
        }
            break;
        default:
            return @"NO TITLE";
    }
    return titleToReturn;
}

- (NSString *)sumToBuy
{
    NSString *sumToReturn = NSLocalizedString(@"No Summ", nil);
    switch (self.inAppType)
    {
        // на самом деле сумма должна браться с сервака
        case EMJInAppTypeAdds:
        {
            sumToReturn = NSLocalizedString(@"99 Руб.", nil);
        }
            break;
        case EMJInAppTypeSpace:
        {
            sumToReturn = NSLocalizedString(@"99 Руб.", nil);
        }
            break;
        case EMJInAppObjectFire:
        {
            sumToReturn = NSLocalizedString(@"99 Руб.", nil);
        }
            break;
        case EMJInAppTypeAnimals:
        {
            sumToReturn = NSLocalizedString(@"99 Руб.", nil);
        }
            break;
        default:
            return @"99 Руб.";
    }
    return sumToReturn;
}

- (NSString *)inAppDescription
{
    NSString *sumToReturn = NSLocalizedString(@"Нет описания", nil);
    switch (self.inAppType)
    {
            // на самом деле сумма должна браться с сервака
        case EMJInAppTypeAdds:
        {
            sumToReturn = NSLocalizedString(@"- Больше никакой рекламы!\n- Более 20 новых эмодзи для серьезных людей - финансы, банкноты, золотые слитки\n- Три новых фильтра - Доллар, Волл-Стрит и Золотце", nil);
        }
            break;
        case EMJInAppTypeSpace:
        {
            sumToReturn = NSLocalizedString(@"- Пора исследовать последний фронтир! Покорите космос с новыми галактическими эмодзи!\n- 'Черная дыра', 'Гиперпространство' и 'Бластеры' - фильтры, созданные специально для отважных покорителей космоса!", nil);
        }
            break;
        case EMJInAppObjectFire:
        {
            sumToReturn = NSLocalizedString(@"- Пора исследовать последний фронтир! Покорите космос с новыми галактическими эмодзи!\n- 'Черная дыра', 'Гиперпространство' и 'Бластеры' - фильтры, созданные специально для отважных покорителей космоса!", nil);
        }
            break;
        case EMJInAppTypeAnimals:
        {
             sumToReturn = NSLocalizedString(@"- Более 35 новых эмодзи с животными, еще больше вариантов эмоджинации!\n- Тропический Лес, Панда, Тундра - новые фильтры для полного единения с природой!\n- Это проще, чем заводить настоящих питомцев!", nil);
        }
            break;
        default:
            return @"99 Руб.";
    }
    return sumToReturn;
    /*
    return NSLocalizedString(@"- Пункт 1 и его описание\n- Пункт 2 и его описание\n- Пункт 3 и его описание", nil);
     */
}

@end
