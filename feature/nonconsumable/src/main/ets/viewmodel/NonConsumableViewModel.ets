import { common } from '@kit.AbilityKit';
import {
  BasePurchaseViewModel,
  IapDomainError,
  IapError,
  iapProductType,
  ProductManager,
  ProductModel
} from 'core';

import { NonConsumableState } from '../state/NonConsumableState';
import { NonConsumableStateEnum } from '../state/INonConsumableState';

export class NonConsumableViewModel extends BasePurchaseViewModel {

  private _state: NonConsumableState = NonConsumableState.initial();
  private listeners: Array<(state: NonConsumableState) => void> = [];
  private readonly TAG = 'NonConsumableViewModel';

  get state(): NonConsumableState {
    return this._state;
  }

  set state(newState: NonConsumableState) {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: NonConsumableState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    this.state = this.state.with({ state: NonConsumableStateEnum.loading });

    try {
      await this.queryProducts(context);
      this.state = this.state.with({ state: NonConsumableStateEnum.completed });
    } catch (error) {
      if (error instanceof IapError) {
        this.state = this.state.with({
          state: NonConsumableStateEnum.error,
          errorMessage: `${error.message} (${error.sdkCode})`
        });
      }
    }
  }

  async queryProducts(context: common.UIAbilityContext): Promise<void> {
    const products = await this.iap.queryProducts(
      context,
      ProductManager.idsOf(ProductManager.nonConsumables),
      iapProductType.NONCONSUMABLE
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
    this.state = this.state.with({ selectedProduct: product,errorMessage: '',state: NonConsumableStateEnum.loading });
  }

  protected override onPurchaseSuccess(product: ProductModel): void {
    this.state = this.state.with({
      state: NonConsumableStateEnum.completed,
      errorMessage: ''
    });
  }

  protected override onPurchaseError(error: IapError): void {

    if (error.domain === IapDomainError.USER_CANCELLED) {
      this.state = this.state.with({
        state: NonConsumableStateEnum.completed
      });
      return;
    }

    this.state = this.state.with({
      state: NonConsumableStateEnum.error,
      errorMessage: `${error.message} (${error.sdkCode})`
    });
  }

  protected override onUnknownError(error: undefined): void {
    this.state = this.state.with({
      state: NonConsumableStateEnum.error,
      errorMessage: `Unknown Error ${error}`
    });
  }
}
