import { HistoryState } from '../state/HistoryState';
import { HistoryStateEnum } from '../state/IHistoryState';
import { common } from '@kit.AbilityKit';
import { IapManager, iapProductType, iapPurchaseQueryType, ProductManager } from 'core';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ProductDefinition } from 'core/src/main/ets/utils/ProductManager'

export class HistoryViewModel {
  private _state: HistoryState = HistoryState.initial();
  private listeners: Array<(state: HistoryState) => void> = [];
  private readonly TAG = 'HistoryViewModel';

  iap?: IapManager;

  get state(): HistoryState {
    return this._state;
  }

  set state(newState: HistoryState) {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: HistoryState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    this.state = this.state.with({ state: HistoryStateEnum.loading });
    this.iap = IapManager.getInstance();

    try {
      const generatedDestructArray = await Promise.all([
        this.queryPurchases(context, iapProductType.CONSUMABLE),
        this.queryPurchases(context, iapProductType.NONCONSUMABLE),
        this.queryPurchases(context, iapProductType.NONRENEWABLE),
        this.querySubPurchases(context)
      ]);
      const consumables = generatedDestructArray[0];
      const nonConsumables = generatedDestructArray[1];
      const nonRenewables = generatedDestructArray[2];
      const subscriptions = generatedDestructArray[3];

      this.state = this.state.with({
        purchaseOrderList: [
          ...consumables,
          ...nonConsumables,
          ...nonRenewables
        ],
        subPurchaseOrderList: subscriptions,
        state: HistoryStateEnum.completed
      });

    } catch (error) {
      hilog.info(0, this.TAG, `init error: ${(error as BusinessError).message}`);
      this.state = this.state.with({ state: HistoryStateEnum.error });
    }
  }

  async queryPurchases(
    context: common.UIAbilityContext,
    type: number
  ): Promise<ProductDefinition[]> {

    const result = await this.iap!.queryPurchaseOrders(
      context,
      type,
      iapPurchaseQueryType.ALL
    );

    const productList: ProductDefinition[] = [];

    for (const item of result) {
      const meta = ProductManager.findById(item.productId);
      if (!meta) {
        continue;
      }

      productList.push({
        id: meta.id,
        type: meta.type,
        title: meta.title,
        icon: meta.icon,
        description: meta.description,
        order: meta.order,

        purchaseTime: ProductManager.formatPurchaseDate(item.purchaseTime),
        price: item.price,
        currency: item.currency
      });
    }

    return productList;
  }

  async querySubPurchases(
    context: common.UIAbilityContext
  ): Promise<ProductDefinition[]> {

    const result = await this.iap!.querySubscriptionOrders(
      context,
      iapPurchaseQueryType.ALL
    );

    const productList: ProductDefinition[] = [];

    for (const item of result) {
      const meta = ProductManager.findById(item.productId);
      if (!meta) {
        continue;
      }

      productList.push({
        id: meta.id,
        type: meta.type,
        title: meta.title,
        icon: meta.icon,
        description: meta.description,
        order: meta.order,

        purchaseTime: ProductManager.formatPurchaseDate(item.purchaseTime),
        price: item.price,
        currency: item.currency
      });
    }

    return productList;
  }
}
