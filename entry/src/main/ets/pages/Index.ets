import { NavigationConstants, NavigationManager } from 'core'
import { ConsumableView } from 'consumable/src/main/ets/view/ConsumableView'
import { NonConsumableView } from 'nonconsumable/src/main/ets/view/NonConsumableView'
import { MenuView } from 'menu/src/main/ets/view/MenuView'
import { HistoryView } from 'history/src/main/ets/view/HistoryView'
import { SplashView } from 'splash/src/main/ets/view/SplashView'
import { SubsAutoView } from 'subsauto/src/main/ets/view/SubsAutoView'
import { SubsNonAutoView } from 'subsnonauto/src/main/ets/view/SubsNonAutoView'

@Entry
@Component
struct Index {
  @Builder
  routeMap(name: string) {
    if (name === NavigationConstants.splash) {
      SplashView()
    } else if (name === NavigationConstants.menu) {
      MenuView()
    } else if (name === NavigationConstants.consumable) {
      ConsumableView()
    } else if (name === NavigationConstants.nonConsumable) {
      NonConsumableView()
    } else if (name === NavigationConstants.subsAuto) {
      SubsAutoView()
    } else if (name === NavigationConstants.subsNonAuto) {
      SubsNonAutoView()
    } else if (name === NavigationConstants.history) {
      HistoryView()
    } else {
      MenuView()
    }
  }

  build() {
    Navigation(NavigationManager.getInstance().pageInfos) {
      SplashView()
    }
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')
  }
}

