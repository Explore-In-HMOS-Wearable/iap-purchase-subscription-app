import { ProductModel } from 'core';
import { SubsNonAutoStateEnum, ISubsNonAutoState } from './ISubsNonAutoState';

export class SubsNonAutoState {
  public state?: SubsNonAutoStateEnum;
  public errorMessage?: string;
  public productList?: ProductModel[];
  public selectedProduct?: ProductModel | null;

  constructor(init: ISubsNonAutoState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
    this.productList = init.productList;
    this.selectedProduct = init.selectedProduct;
  }

  with(updates: ISubsNonAutoState): SubsNonAutoState {
    return new SubsNonAutoState({
      state: updates.state ?? this.state,
      errorMessage: updates.errorMessage ?? this.errorMessage,
      productList: updates.productList ?? this.productList,
      selectedProduct: updates.selectedProduct ?? this.selectedProduct
    });
  }

  static initial(): SubsNonAutoState {
    return new SubsNonAutoState({
      state: SubsNonAutoStateEnum.initial,
      errorMessage: '',
      productList: [],
      selectedProduct: null
    });
  }
}
