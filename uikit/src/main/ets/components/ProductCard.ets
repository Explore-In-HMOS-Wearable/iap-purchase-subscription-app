import { ProductModel } from 'core'

@Component
export struct ProductCard {
  item!: ProductModel
  onBuy?: (item: ProductModel) => void

  build() {
    Column({ space: 10 }) {

      if (this.item.image) {
        Image(this.item.image)
          .width(48)
          .height(48)
          .margin({ bottom: 6 })
      }

      this.renderTitle()
      this.renderDescription()
      this.renderBuyButton()
    }
    .padding(12)
    .backgroundColor('#222222')
    .borderRadius(20)
    .width('85%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private renderTitle() {
    Text(this.item.displayName)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .textAlign(TextAlign.Center)

    if (this.item.localPrice) {
      Text(this.item.localPrice)
        .fontSize(16)
        .fontColor('#88FFFFFF')
        .textAlign(TextAlign.Center)
    }
  }

  @Builder
  private renderDescription() {
    if (this.item.description) {
      Text(this.item.description)
        .fontSize(14)
        .fontColor('#88FFFFFF')
        .textAlign(TextAlign.Center)
    }
  }

  @Builder
  private renderBuyButton() {
    Button('Buy')
      .width(110)
      .height(38)
      .fontSize(16)
      .backgroundColor('#3399FF')
      .borderRadius(20)
      .onClick(() => {
        this.onBuy?.(this.item)
      })
  }
}