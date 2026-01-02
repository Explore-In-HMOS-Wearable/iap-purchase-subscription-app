import { common } from '@kit.AbilityKit';
import {
  BasePurchaseViewModel,
  IapDomainError,
  IapError,
  iapProductType,
  ProductManager,
  ProductModel
} from 'core';

import { SubsNonAutoState } from '../state/SubsNonAutoState';
import { SubsNonAutoStateEnum } from '../state/ISubsNonAutoState';

export class SubsNonAutoViewModel extends BasePurchaseViewModel {

  private _state: SubsNonAutoState = SubsNonAutoState.initial();
  private listeners: Array<(state: SubsNonAutoState) => void> = [];
  private readonly TAG = 'SubsNonAutoViewModel';

  get state(): SubsNonAutoState {
    return this._state;
  }

  set state(newState: SubsNonAutoState) {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: SubsNonAutoState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    this.state = this.state.with({ state: SubsNonAutoStateEnum.loading });

    try {
      await this.queryProducts(context);
      this.state = this.state.with({ state: SubsNonAutoStateEnum.completed });
    } catch (error) {
      if (error instanceof IapError) {
        this.state = this.state.with({
          state: SubsNonAutoStateEnum.error,
          errorMessage: `${error.message} (${error.sdkCode})`
        });
      }
    }
  }

  async queryProducts(context: common.UIAbilityContext): Promise<void> {
    const products = await this.iap.queryProducts(
      context,
      ProductManager.idsOf(ProductManager.nonRenewings),
      iapProductType.NONRENEWABLE
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
    this.state = this.state.with({ selectedProduct: product,errorMessage: '',state: SubsNonAutoStateEnum.loading });
  }

  protected override onPurchaseSuccess(product: ProductModel): void {
    this.state = this.state.with({
      state: SubsNonAutoStateEnum.completed,
      errorMessage: ''
    });
  }

  protected override onPurchaseError(error: IapError): void {

    if (error.domain === IapDomainError.USER_CANCELLED) {
      this.state = this.state.with({
        state: SubsNonAutoStateEnum.completed
      });
      return;
    }

    this.state = this.state.with({
      state: SubsNonAutoStateEnum.error,
      errorMessage: `${error.message} (${error.sdkCode})`
    });
  }

  protected override onUnknownError(error: undefined): void {
    this.state = this.state.with({
      state: SubsNonAutoStateEnum.error,
      errorMessage: `Unknown Error ${error}`
    });
  }
}
