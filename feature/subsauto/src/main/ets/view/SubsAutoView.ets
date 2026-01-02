import { AbilityContextProvider, ProductModel } from 'core'
import { ProductPageBody } from 'uikit'
import { SubsAutoStateEnum } from '../state/ISubsAutoState'
import { SubsAutoState } from '../state/SubsAutoState'
import { SubsAutoViewModel } from '../viewmodel/SubsAutoViewModel'

@Component
export struct SubsAutoView {

  private context = AbilityContextProvider.get()
  private viewModel: SubsAutoViewModel = new SubsAutoViewModel()

  @State state: SubsAutoState = SubsAutoState.initial()

  aboutToAppear(): void {
    this.viewModel.addListener(this.onStateChanged)
    this.viewModel.init(this.context)
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners()
  }

  private onStateChanged = (newState: SubsAutoState) => {
    this.state = newState
  }

  build() {
    NavDestination() {
      ProductPageBody({
        header: 'SubsAutoView',
        isLoading: this.state.state === SubsAutoStateEnum.loading,
        isError: this.state.state === SubsAutoStateEnum.error,
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
