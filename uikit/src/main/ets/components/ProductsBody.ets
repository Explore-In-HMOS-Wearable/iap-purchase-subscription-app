import { ProductModel } from 'core'
import { ProductCard } from './ProductCard'

@Component
export struct ProductsBody {
  products!: ProductModel[]
  onBuy!: (product: ProductModel) => void

  build() {
    Column({ space: 10 }) {
      ForEach(this.products, (item: ProductModel) => {
        ProductCard({
          item,
          onBuy: () => this.onBuy(item)
        })
      }, (item : ProductModel) => item.id)
    }
  }
}
