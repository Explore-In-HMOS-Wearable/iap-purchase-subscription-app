import { ProductModel } from 'core';

export enum SubsNonAutoStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface ISubsNonAutoState {
  state?: SubsNonAutoStateEnum;
  errorMessage?: string;
  productList?: ProductModel[];
  selectedProduct?: ProductModel | null;
}
