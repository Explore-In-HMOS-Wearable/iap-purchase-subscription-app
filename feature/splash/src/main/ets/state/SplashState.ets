import './ISplashState'
import { ISplashState, SplashStateEnum } from './ISplashState';

export class SplashState {
  public errorMessage?: string;
  public state?: SplashStateEnum;

  constructor(init: ISplashState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
  }

  with(updates: ISplashState): SplashState {
    return new SplashState({
      errorMessage: updates.errorMessage ?? this.errorMessage,
      state: updates.state ?? this.state
    });
  }

  static initial(): SplashState {
    return new SplashState({
      errorMessage: '',
      state: SplashStateEnum.initial
    });
  }
}
