import { ProductModel } from 'core';
import { ConsumableStateEnum, IConsumableState } from './IConsumableState';

export class ConsumableState {
  public state?: ConsumableStateEnum;
  public errorMessage?: string;
  public productList?: ProductModel[];
  public selectedProduct?: ProductModel | null;

  constructor(init: IConsumableState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
    this.productList = init.productList;
    this.selectedProduct = init.selectedProduct;
  }

  with(updates: IConsumableState): ConsumableState {
    return new ConsumableState({
      state: updates.state ?? this.state,
      errorMessage: updates.errorMessage ?? this.errorMessage,
      productList: updates.productList ?? this.productList,
      selectedProduct: updates.selectedProduct ?? this.selectedProduct
    });
  }

  static initial(): ConsumableState {
    return new ConsumableState({
      state: ConsumableStateEnum.initial,
      errorMessage: '',
      productList: [],
      selectedProduct: null
    });
  }
}
