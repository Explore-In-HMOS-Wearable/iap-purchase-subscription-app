import { ProductDefinition } from 'core/src/main/ets/utils/ProductManager'
import './IHistoryState'
import { IHistoryState, HistoryStateEnum } from './IHistoryState';

export class HistoryState {
  public errorMessage?: string;
  public state?: HistoryStateEnum;
  public purchaseOrderList?: ProductDefinition[];
  public subPurchaseOrderList?: ProductDefinition[];


  constructor(init: IHistoryState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
    this.purchaseOrderList = init.purchaseOrderList;
    this.subPurchaseOrderList = init.subPurchaseOrderList;
  }

  with(updates: IHistoryState): HistoryState {
    return new HistoryState({
      errorMessage: updates.errorMessage ?? this.errorMessage,
      state: updates.state ?? this.state,
      purchaseOrderList: updates.purchaseOrderList ?? this.purchaseOrderList,
      subPurchaseOrderList: updates.subPurchaseOrderList ?? this.subPurchaseOrderList
    });
  }

  static initial(): HistoryState {
    return new HistoryState({
      errorMessage: '',
      state: HistoryStateEnum.initial,
      purchaseOrderList: [],
      subPurchaseOrderList: []
    });
  }
}
