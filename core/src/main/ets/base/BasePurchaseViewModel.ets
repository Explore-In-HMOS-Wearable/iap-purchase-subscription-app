// core/viewmodel/BasePurchaseViewModel.ts

import { common } from '@kit.AbilityKit';
import { IapError, IapManager } from '../iap/IapManager';
import { ProductModel } from '../iap/models/ProductModel';

export abstract class BasePurchaseViewModel {

  protected readonly iap: IapManager = IapManager.getInstance();


  async purchase(
    context: common.UIAbilityContext,
    product: ProductModel
  ): Promise<void> {
    try {
      this.onPurchaseStart(product);

      const result = await this.iap.createPurchase(
        context,
        product.id!,
        product.type!
      );

      await this.iap.handleCreatePurchaseResult(result, context, product.type!);

      this.onPurchaseSuccess(product);

    } catch (error) {
      if (error instanceof IapError) {
        this.onPurchaseError(error);
      } else {
        this.onUnknownError(error);
      }
    }
  }


  protected onPurchaseStart(product: ProductModel): void {}

  protected onPurchaseSuccess(product: ProductModel): void {}

  protected onPurchaseError(error: IapError): void {}

  protected onUnknownError(error: undefined): void {}
}
