import { IMenuState, MenuStateEnum } from './IMenuState';

export class MenuState {
  public errorMessage?: string;
  public state?: MenuStateEnum;

  constructor(init: IMenuState) {
    this.state = init.state;
    this.errorMessage = init.errorMessage;
  }

  with(updates: IMenuState): MenuState {
    return new MenuState({
      errorMessage: updates.errorMessage ?? this.errorMessage,
      state: updates.state ?? this.state
    });
  }

  static initial(): MenuState {
    return new MenuState({
      errorMessage: '',
      state: MenuStateEnum.initial
    });
  }
}
