import { ProductModel } from 'core';

export enum NonConsumableStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface INonConsumableState {
  state?: NonConsumableStateEnum;
  errorMessage?: string;
  productList?: ProductModel[];
  selectedProduct?: ProductModel | null;
}
