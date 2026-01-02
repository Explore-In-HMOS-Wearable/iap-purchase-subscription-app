import { SplashState } from '../state/SplashState';
import { SplashViewModel } from '../viewmodel/SplashViewModel';
import { SplashStateEnum } from '../state/ISplashState';

@Component
export struct SplashView {

  private viewModel: SplashViewModel = new SplashViewModel();
  @State state: SplashState = SplashState.initial();

  aboutToAppear(): void {
    this.viewModel.addListener((newState: SplashState) => {
      this.state = newState;
    });

    this.viewModel.init();
  }

  aboutToDisappear(): void {
    this.viewModel.removeAllListeners();
  }

  build() {
    NavDestination() {
      Column({ space: 16 }) {

        if (this.state.state === SplashStateEnum.loading) {
          LoadingProgress();
          Text('SmartAd Beacon')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .opacity(0.8);
        }

        if (this.state.state === SplashStateEnum.error) {
          Text(this.state.errorMessage)
            .fontColor(Color.Red)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .margin({ left: 12, right: 12 });
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .hideBackButton(true);
  }
}
