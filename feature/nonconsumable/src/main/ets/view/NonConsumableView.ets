import { AbilityContextProvider, ProductModel } from 'core'
import { ProductPageBody } from 'uikit'
import { NonConsumableStateEnum } from '../state/INonConsumableState'
import { NonConsumableState } from '../state/NonConsumableState'
import { NonConsumableViewModel } from '../viewmodel/NonConsumableViewModel'

@Component
export struct NonConsumableView {

  private context = AbilityContextProvider.get()
  private viewModel: NonConsumableViewModel = new NonConsumableViewModel()

  @State state: NonConsumableState = NonConsumableState.initial()

  aboutToAppear(): void {
    this.viewModel.addListener(this.onStateChanged)
    this.viewModel.init(this.context)
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners()
  }

  private onStateChanged = (newState: NonConsumableState) => {
    this.state = newState
  }

  build() {
    NavDestination() {
      ProductPageBody({
        header: 'NonConsumable',
        isLoading: this.state.state === NonConsumableStateEnum.loading,
        isError: this.state.state === NonConsumableStateEnum.error,
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
