import { ProductModel } from 'core';

export enum ConsumableStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface IConsumableState {
  state?: ConsumableStateEnum;
  errorMessage?: string;
  productList?: ProductModel[];
  selectedProduct?: ProductModel | null;
}
