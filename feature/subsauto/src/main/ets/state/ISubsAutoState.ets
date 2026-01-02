import { ProductModel } from 'core';

export enum SubsAutoStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface ISubsAutoState {
  state?: SubsAutoStateEnum;
  errorMessage?: string;
  productList?: ProductModel[];
  selectedProduct?: ProductModel | null;
}
