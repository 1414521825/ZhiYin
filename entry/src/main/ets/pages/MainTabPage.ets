import { ChatPage } from './ChatPage';
import { ReviewPage } from './ReviewPage';
import { SettingsPage } from './SettingsPage';
import { TodayPage } from './TodayPage';

@ComponentV2
export struct MainTabPage {
  @Local private selectedIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.selectedIndex }) {
      TabContent() {
        TodayPage()
      }
      .tabBar(this.buildTabBar(0, '今日', $r('app.media.tab_today_normal'), $r('app.media.tab_today_selected')))

      TabContent() {
        ChatPage()
      }
      .tabBar(this.buildTabBar(1, '导师', $r('app.media.tab_chat_normal'), $r('app.media.tab_chat_selected')))

      TabContent() {
        ReviewPage()
      }
      .tabBar(this.buildTabBar(2, '复盘', $r('app.media.tab_review_normal'), $r('app.media.tab_review_selected')))

      TabContent() {
        SettingsPage()
      }
      .tabBar(this.buildTabBar(3, '设置', $r('app.media.tab_settings_normal'), $r('app.media.tab_settings_selected')))
    }
    .onChange((index: number) => {
      this.selectedIndex = index;
    })
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
    .animationDuration(0)
  }

  @Builder
  private buildTabBar(index: number, label: string, normalIcon: Resource, selectedIcon: Resource) {
    Column({ space: 3 }) {
      Image(this.selectedIndex === index ? selectedIcon : normalIcon)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)

      Text(label)
        .fontSize(11)
        .fontColor(this.selectedIndex === index ? '#0A6CFF' : '#7A8494')
        .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Regular)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
  }
}
