import { AbilityContextProvider, ProductModel } from 'core'
import { ProductPageBody } from 'uikit'
import { ConsumableState } from '../state/ConsumableState'
import { ConsumableStateEnum } from '../state/IConsumableState'
import { ConsumableViewModel } from '../viewmodel/ConsumableViewModel'

@Component
export struct ConsumableView {

  private context = AbilityContextProvider.get()
  private viewModel: ConsumableViewModel = new ConsumableViewModel()

  @State state: ConsumableState = ConsumableState.initial()

  aboutToAppear(): void {
    this.viewModel.addListener(this.onStateChanged)
    this.viewModel.init(this.context)
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners()
  }

  private onStateChanged = (newState: ConsumableState) => {
    this.state = newState

  }

  build() {
    NavDestination() {
      ProductPageBody({
        header: 'Consumable',
        isLoading: this.state.state === ConsumableStateEnum.loading,
        isError: this.state.state === ConsumableStateEnum.error,
        errorMessage: this.state.errorMessage,
        products: this.state.productList,
        onBuy: (product): Promise<void> => this.onBuyClick(product)
      })
    }
    .hideBackButton(true)
  }

  async onBuyClick(product: ProductModel) {
    await this.viewModel.createPurchase(this.context, product)
  }

}


