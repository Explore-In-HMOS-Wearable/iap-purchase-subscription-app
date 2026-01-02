import { NavigationConstants } from 'core';

export interface MainMenuItem {
  id: string;
  icon: Resource;
  title: string;
  route: NavigationConstants;
}

export const mainMenuItems: MainMenuItem[] = [
  {
    id: 'consumable',
    icon: $r('sys.media.clone_app_badge_1'),
    title: 'Consumable',
    route: NavigationConstants.consumable
  },
  {
    id: 'non_consumable',
    icon: $r('sys.media.clone_app_badge_2'),
    title: 'Non-Consumable',
    route: NavigationConstants.nonConsumable
  },
  {
    id: 'subs_auto',
    icon: $r('sys.media.clone_app_badge_3'),
    title: 'Subscription (Auto)',
    route: NavigationConstants.subsAuto
  },
  {
    id: 'subs_non_auto',
    icon: $r('sys.media.clone_app_badge_4'),
    title: 'Subscription (Non-Auto)',
    route: NavigationConstants.subsNonAuto
  },
  {
    id: 'history',
    icon: $r('sys.media.clone_app_badge_5'),
    title: 'Purchase History',
    route: NavigationConstants.history
  }
];
