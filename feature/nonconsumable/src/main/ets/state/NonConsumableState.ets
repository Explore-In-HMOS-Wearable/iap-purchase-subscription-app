import { ProductModel } from 'core';
import { NonConsumableStateEnum, INonConsumableState } from './INonConsumableState';

export class NonConsumableState {
  public state?: NonConsumableStateEnum;
  public errorMessage?: string;
  public productList?: ProductModel[];
  public selectedProduct?: ProductModel | null;

  constructor(init: INonConsumableState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
    this.productList = init.productList;
    this.selectedProduct = init.selectedProduct;
  }

  with(updates: INonConsumableState): NonConsumableState {
    return new NonConsumableState({
      state: updates.state ?? this.state,
      errorMessage: updates.errorMessage ?? this.errorMessage,
      productList: updates.productList ?? this.productList,
      selectedProduct: updates.selectedProduct ?? this.selectedProduct
    });
  }

  static initial(): NonConsumableState {
    return new NonConsumableState({
      state: NonConsumableStateEnum.initial,
      errorMessage: '',
      productList: [],
      selectedProduct: null
    });
  }
}
