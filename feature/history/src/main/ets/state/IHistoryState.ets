import { ProductDefinition } from 'core/src/main/ets/utils/ProductManager'

export enum HistoryStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface IHistoryState {
  state?: HistoryStateEnum;
  errorMessage?: string;
  purchaseOrderList?: ProductDefinition[];
  subPurchaseOrderList?: ProductDefinition[];
}
