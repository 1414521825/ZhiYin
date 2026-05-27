import { SettingsViewState } from '../models/ViewStates';
import { SettingsViewModel } from '../viewmodels/SettingsViewModel';

@ComponentV2
export struct SettingsPage {
  private viewModel: SettingsViewModel = new SettingsViewModel();
  @Local private state: SettingsViewState = this.viewModel.getInitialState();

  build() {
    Scroll() {
      Column({ space: 18 }) {
        Text('系统设置')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Column({ space: 14 }) {
          Text('学习目标')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100%')
          this.settingLine('当前目标', this.state.learningGoal)
          this.settingLine('每日可投入', `${this.state.dailyAvailableMinutes} 分钟`)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)

        Column({ space: 14 }) {
          Text('自动化时间轴')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100%')
          this.settingLine('早间计划', this.state.morningReminderTime)
          this.settingLine('夜间复盘', this.state.nightReviewTime)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)

        Column({ space: 14 }) {
          Text('凭证管理')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100%')
          this.settingLine('Git 仓库', this.state.repositoryUrl)
          this.settingLine('授权状态', this.state.repositoryAuthStatus)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)

        Button('退出登录')
          .width('100%')
          .height(46)
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  private settingLine(label: string, value: string) {
    Column({ space: 6 }) {
      Text(label)
        .fontSize(12)
        .fontColor('#7A8494')
        .width('100%')

      Text(value)
        .fontSize(14)
        .fontColor('#1F2329')
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
