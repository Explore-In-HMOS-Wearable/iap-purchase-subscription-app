import { AbilityContextProvider, IapManager, PurchaseOrderPayload, SubscriptionPurchaseOrder } from 'core'
import { HistoryState } from '../state/HistoryState'
import { HistoryStateEnum } from '../state/IHistoryState'
import { HistoryViewModel } from '../viewmodel/HistoryViewModel'
import { ProductDefinition } from 'core/src/main/ets/utils/ProductManager'



@Component
export struct HistoryView {

  private viewModel : HistoryViewModel = new HistoryViewModel()
  @State state : HistoryState = HistoryState.initial()
  private context = AbilityContextProvider.get()

  aboutToAppear(): void {
    this.viewModel.addListener(this.onStateChanged)
    this.viewModel.init(this.context)
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners()
  }

  private onStateChanged = (newState: HistoryState) => {
    this.state = newState
  }

  build() {
    NavDestination() {
      if (this.state.state === HistoryStateEnum.loading){
        LoadingProgress()
      } else {
        Scroll(){
          Column() {
            this.renderTitle()
            this.renderContent()
          }
          .width('100%')
        }
        .width('100%')
      }
    }
    .hideBackButton(true)
  }


  @Builder
  private renderTitle() {
    Text('Order History')
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 20, bottom: 16 })
      .textAlign(TextAlign.Center)
  }


  @Builder
  private renderContent() {
    if (this.state.state === HistoryStateEnum.loading) {
      this.renderLoading()
    } else if (this.state.purchaseOrderList?.length === 0 && this.state.subPurchaseOrderList?.length === 0) {
      this.renderEmpty()
    } else {
      this.renderHistoryList()
    }
  }


  @Builder
  private renderLoading() {
    LoadingProgress()
  }

  @Builder
  private renderEmpty() {
    Column({ space: 8 }) {
      Text('No purchase history')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text('Your completed purchases will appear here')
        .fontSize(13)
        .fontColor('#88FFFFFF')
    }
    .margin({ top: 60 })
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }


  @Builder
  private renderHistoryList() {
      Column({ space: 12 }) {

        ForEach(this.state.purchaseOrderList, (item: ProductDefinition) => {
          this.renderHistoryItem(item)
        },(item : ProductDefinition) => item.id)
        ForEach(this.state.subPurchaseOrderList, (item: ProductDefinition) => {
          this.renderSubHistoryItem(item)
        }, (item : ProductDefinition) => item.id)
      }
      .width('100%')
  }


  @Builder
  private renderHistoryItem(item: ProductDefinition) {
    Column({ space: 6 }) {
      if (item.icon) {
        Image(item.icon)
          .width(48)
          .height(48)
          .margin({ bottom: 6 })
      }

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`${item.price} ${item.currency}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`PT: ${item.purchaseTime}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`${item.description}`)
        .fontSize(14)
        .fontColor('#88FFFFFF')

    }
    .padding(12)
    .backgroundColor('#1E1E1E')
    .borderRadius(16)
    .width('90%')
  }

  @Builder
  private renderSubHistoryItem(item: ProductDefinition) {
    Column({ space: 6 }) {
      if (item.icon) {
        Image(item.icon)
          .width(48)
          .height(48)
          .margin({ bottom: 6 })
      }

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`${item.price} ${item.currency}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`PT: ${item.purchaseTime}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text(`${item.description}`)
        .fontSize(14)
        .fontColor('#88FFFFFF')

    }
    .padding(12)
    .backgroundColor('#1E1E1E')
    .borderRadius(16)
    .width('90%')
  }
}