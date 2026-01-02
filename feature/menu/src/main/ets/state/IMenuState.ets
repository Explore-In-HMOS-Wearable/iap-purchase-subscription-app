export enum MenuStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface IMenuState {
  state: MenuStateEnum;
  errorMessage?: string;
}
