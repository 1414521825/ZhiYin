import { ChatPage } from './ChatPage';
import { ReviewPage } from './ReviewPage';
import { SettingsPage } from './SettingsPage';
import { TodayPage } from './TodayPage';

@ComponentV2
export struct MainTabPage {
  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        TodayPage()
      }
      .tabBar('今日')

      TabContent() {
        ChatPage()
      }
      .tabBar('导师')

      TabContent() {
        ReviewPage()
      }
      .tabBar('复盘')

      TabContent() {
        SettingsPage()
      }
      .tabBar('设置')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
    .animationDuration(0)
  }
}
