import { OnboardingViewState } from '../models/ViewStates';
import { OnboardingViewModel } from '../viewmodels/OnboardingViewModel';

@ComponentV2
export struct OnboardingPage {
  @Event
  onComplete: () => void = () => {};
  private viewModel: OnboardingViewModel = new OnboardingViewModel();
  @Local private state: OnboardingViewState = this.viewModel.getInitialState();

  build() {
    Column({ space: 20 }) {
      Text('初始化学习配置')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text('Phase 1 使用 Mock 配置，后续接入后端后从真实账号配置加载。')
        .fontSize(14)
        .fontColor('#5F6673')
        .width('100%')

      Column({ space: 14 }) {
        this.infoRow('学习目标', this.state.learningGoal)
        this.infoRow('目标周期', this.state.targetPeriod)
        this.infoRow('Git 仓库', this.state.repositoryUrl)
        this.infoRow('授权状态', this.state.tokenStatus)
      }
      .width('100%')
      .padding(18)
      .borderRadius(8)
      .backgroundColor(Color.White)

      Button('完成初始化，进入首页')
        .width('100%')
        .height(48)
        .onClick(() => {
          this.onComplete();
        })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 36 })
    .backgroundColor('#F7F8FA')
  }

  @Builder
  private infoRow(label: string, value: string) {
    Column({ space: 6 }) {
      Text(label)
        .fontSize(12)
        .fontColor('#7A8494')
      Text(value)
        .fontSize(15)
        .fontColor('#1F2329')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}
