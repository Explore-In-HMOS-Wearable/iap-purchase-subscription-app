import { common } from '@kit.AbilityKit';
import {
  BasePurchaseViewModel,
  IapDomainError,
  IapError,
  iapProductType,
  ProductManager,
  ProductModel
} from 'core';

import { ConsumableState } from '../state/ConsumableState';
import { ConsumableStateEnum } from '../state/IConsumableState';

export class ConsumableViewModel extends BasePurchaseViewModel {

  private _state: ConsumableState = ConsumableState.initial();
  private listeners: Array<(state: ConsumableState) => void> = [];
  private readonly TAG = 'ConsumableViewModel';


  get state(): ConsumableState {
    return this._state;
  }

  set state(newState: ConsumableState) {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: ConsumableState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    this.state = this.state.with({ state: ConsumableStateEnum.loading });

    try {
      await this.queryProducts(context);
      this.state = this.state.with({ state: ConsumableStateEnum.completed });
    } catch (error) {
      if (error instanceof IapError) {
        this.state = this.state.with({
          state: ConsumableStateEnum.error,
          errorMessage: `${error.message} (${error.sdkCode})`
        });
      }
    }
  }


  async queryProducts(context: common.UIAbilityContext): Promise<void> {
    const products = await this.iap.queryProducts(
      context,
      ProductManager.idsOf(ProductManager.consumables),
      iapProductType.CONSUMABLE
    );

    const enrichedProducts = products.map(product => {
      const meta = ProductManager.findMeta(product.id!);

      product.displayName = meta?.displayName ?? product.name;
      product.image = meta?.image;

      return product;
    });

    this.state = this.state.with({
      productList: enrichedProducts
    });
  }



  async createPurchase(
    context: common.UIAbilityContext,
    product: ProductModel
  ): Promise<void> {
    await this.purchase(context, product);
  }


  protected override onPurchaseStart(product: ProductModel): void {
    this.state = this.state.with({ selectedProduct: product,errorMessage: '',state: ConsumableStateEnum.loading });
  }

  protected override onPurchaseSuccess(product: ProductModel): void {
    this.state = this.state.with({
      state: ConsumableStateEnum.completed,
      errorMessage: ''
    });
  }

  protected override onPurchaseError(error: IapError): void {

    if (error.domain === IapDomainError.USER_CANCELLED) {
      this.state = this.state.with({
        state: ConsumableStateEnum.completed
      });
      return;
    }

    this.state = this.state.with({
      state: ConsumableStateEnum.error,
      errorMessage: `${error.message} (${error.sdkCode})`
    });
  }

  protected override onUnknownError(error: undefined): void {
    this.state = this.state.with({
      state: ConsumableStateEnum.error,
      errorMessage: `Unknown Error ${error}`
    });
  }

}
