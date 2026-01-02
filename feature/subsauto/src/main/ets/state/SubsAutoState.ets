import { ProductModel } from 'core';
import { SubsAutoStateEnum, ISubsAutoState } from './ISubsAutoState';

export class SubsAutoState {
  public state?: SubsAutoStateEnum;
  public errorMessage?: string;
  public productList?: ProductModel[];
  public selectedProduct?: ProductModel | null;

  constructor(init: ISubsAutoState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
    this.productList = init.productList;
    this.selectedProduct = init.selectedProduct;
  }

  with(updates: ISubsAutoState): SubsAutoState {
    return new SubsAutoState({
      state: updates.state ?? this.state,
      errorMessage: updates.errorMessage ?? this.errorMessage,
      productList: updates.productList ?? this.productList,
      selectedProduct: updates.selectedProduct ?? this.selectedProduct
    });
  }

  static initial(): SubsAutoState {
    return new SubsAutoState({
      state: SubsAutoStateEnum.initial,
      errorMessage: '',
      productList: [],
      selectedProduct: null
    });
  }
}
