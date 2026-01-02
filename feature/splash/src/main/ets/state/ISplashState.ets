export enum SplashStateEnum{
  initial,
  loading,
  error,
  completed
}

export interface ISplashState {
  state: SplashStateEnum;
  errorMessage?: string;
}
