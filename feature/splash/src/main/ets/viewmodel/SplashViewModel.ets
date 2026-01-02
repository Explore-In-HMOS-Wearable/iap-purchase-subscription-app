import { SplashState } from '../state/SplashState';
import { SplashStateEnum } from '../state/ISplashState';
import { NavigationConstants, NavigationManager } from 'core';

export class SplashViewModel {

  private _state: SplashState = SplashState.initial();
  private listeners: Array<(state: SplashState) => void> = [];
  private readonly TAG = 'SplashViewModel';

  get state(): SplashState {
    return this._state;
  }

  private setState(newState: SplashState): void {
    this._state = newState;
    this.notifyListeners();
  }

  addListener(listener: (state: SplashState) => void): void {
    this.listeners.push(listener);
  }

  removeAllListeners(): void {
    this.listeners = [];
  }

  private notifyListeners(): void {
    this.listeners.forEach(listener => listener(this._state));
  }

  async init(): Promise<void> {
    this.setState(this.state.with({ state: SplashStateEnum.loading }));

    await this.delay(800);

    this.setState(this.state.with({ state: SplashStateEnum.completed }));

    this.navigateNext();
  }

  private navigateNext(): void {
    NavigationManager
      .getInstance()
      .pageInfos
      .pushPath({ name: NavigationConstants.menu });
  }

  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}
