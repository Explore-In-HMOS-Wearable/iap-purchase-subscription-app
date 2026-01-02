import { ProductModel } from 'core'
import { ProductsBody } from './ProductsBody'
import { ProductTitle } from './ProductTitle'

@Component
export struct ProductListComponent {
  header!: string
  products!: ProductModel[]
  onBuy!: (product: ProductModel) => void

  build() {
    Scroll() {
      Column({ space: 10 }) {
        ProductTitle({title: this.header})
        ProductsBody({
          products: this.products,
          onBuy: this.onBuy
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}
