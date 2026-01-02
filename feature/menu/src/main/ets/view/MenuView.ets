
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, ComponentContent, LengthMetrics, UIContext } from '@kit.ArkUI';
import { NavigationManager } from 'core';
import { MainMenuItem, mainMenuItems } from '../components/MainMenuItem';

@Builder
function buildText() {
  Text('IAP Example')
    .fontSize('36px')
    .fontWeight(FontWeight.Bold)
}

@Entry
@Component
export struct MenuView {

  private watchSize: string = '466px'
  private listSize: string = '410px'
  context: UIContext = this.getUIContext()
  tabBar1: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));

  build() {
    NavDestination(){
      Column() {
        Stack() {
          ArcList({ initialIndex: 0, header: this.tabBar1 }) {
            ForEach(mainMenuItems, (item: MainMenuItem) => {
              ArcListItem() {
                Button({ type: ButtonType.Capsule }) {
                  Row() {
                    Image(item.icon)
                      .width('64px')
                      .height('64px')
                      .margin({ right: '12px' })
                    Text(`${item.title}`)
                      .fontSize('36px')
                      .fontColor(Color.Black)
                      .fontWeight(FontWeight.Bold)
                  }
                  .justifyContent(FlexAlign.Center)
                  .width('100%')
                }
                .width(this.listSize)
                .height('100px')
                .fontSize('24px')
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .focusable(true)
                .opacity(0.9)
                .focusOnTouch(true)
                .backgroundColor('#f0f8ff')
              }.align(Alignment.Center)
                .onClick(() => {
                  NavigationManager.getInstance().pageInfos.pushPath({name: item.route as string})
                })

            }, (item: string, index: number) => item)
          }
          .space(LengthMetrics.px(10))
          .borderRadius(this.watchSize)
          .focusable(true)
          .focusOnTouch(true)
          .defaultFocus(true)
        }
        .align(Alignment.Center)
        .width(this.watchSize)
        .height(this.watchSize)
        .border({color: Color.Black, width: 3})
        .borderRadius(this.watchSize)
      }
      .height('100%')
      .width('100%')
    }
    .hideBackButton(true)
  }
}