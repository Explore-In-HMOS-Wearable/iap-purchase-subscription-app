import { MenuState } from '../state/MenuState';

export class MenuViewModel {
  private _state: MenuState = MenuState.initial();
  private listeners: Array<(state: MenuState) => void> = [];
  private readonly TAG = 'MenuViewModel';

  get state(): MenuState {
    return this._state;
  }

  set state(newState: MenuState) {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: MenuState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

}
