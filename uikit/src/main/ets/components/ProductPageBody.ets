import { ProductModel } from 'core'
import { ProductListComponent } from './ProductListComponent'

@Component
export struct ProductPageBody {
  header?: string
  @Prop isLoading?: boolean = false
  @Prop isError?: boolean = false
  @Prop products?: ProductModel[] = []
  @Prop errorMessage?: string = ''
  onBuy?: (product: ProductModel) => void

  build() {
    if (this.isLoading) {
      LoadingProgress()
    } else {
      Column({ space: 8 }) {
        if (this.isError && this.errorMessage != null && this.errorMessage.trim().length > 0) {
          Text(this.errorMessage)
            .fontSize(12)
            .fontColor('#FF6B6B')
            .textAlign(TextAlign.Center)
            .margin({ top: 32, bottom: 6,left: 6, right: 6 })
        }

        ProductListComponent({
          header: this.header,
          products: this.products,
          onBuy: this.onBuy
        })
      }
    }
  }
}
