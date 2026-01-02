import { AbilityContextProvider, ProductModel } from 'core'
import { ProductPageBody } from 'uikit'
import { SubsNonAutoStateEnum } from '../state/ISubsNonAutoState'
import { SubsNonAutoState } from '../state/SubsNonAutoState'
import { SubsNonAutoViewModel } from '../viewmodel/SubsNonAutoViewModel'

@Component
export struct SubsNonAutoView {

  private context = AbilityContextProvider.get()
  private viewModel: SubsNonAutoViewModel = new SubsNonAutoViewModel()

  @State state: SubsNonAutoState = SubsNonAutoState.initial()

  aboutToAppear(): void {
    this.viewModel.addListener(this.onStateChanged)
    this.viewModel.init(this.context)
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners()
  }

  private onStateChanged = (newState: SubsNonAutoState) => {
    this.state = newState
  }

  build() {
    NavDestination() {
      ProductPageBody({
        header: 'Non Renew',
        isLoading: this.state.state === SubsNonAutoStateEnum.loading,
        isError: this.state.state === SubsNonAutoStateEnum.error,
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
