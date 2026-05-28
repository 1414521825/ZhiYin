import { ChatPage } from './ChatPage';
import { ReviewPage } from './ReviewPage';
import { SettingsPage } from './SettingsPage';
import { TodayPage } from './TodayPage';

@ComponentV2
export struct MainTabPage {
  @Local private selectedIndex: number = 0;
  @Local private gestureTargetIndex: number = 0;
  @Local private isGestureSwiping: boolean = false;
  @Local private tabsContentWidthVp: number = 360;
  private readonly tabCount: number = 4;
  private readonly swipeSwitchRatio: number = 0.5;
  private readonly minSwipeThresholdVp: number = 120;

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
      this.gestureTargetIndex = index;
      this.isGestureSwiping = false;
    })
    .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
      this.updateGestureTargetIndex(index, event.currentOffset);
    })
    .onAnimationEnd((index: number, event: TabsAnimationEvent) => {
      this.selectedIndex = index;
      this.gestureTargetIndex = index;
      this.isGestureSwiping = false;
    })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.tabsContentWidthVp = this.parseAreaLength(newValue.width, this.tabsContentWidthVp);
    })
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
    .animationDuration(0)
  }

  @Builder
  private buildTabBar(index: number, label: string, normalIcon: Resource, selectedIcon: Resource) {
    Column({ space: 3 }) {
      Image(this.getDisplayIndex() === index ? selectedIcon : normalIcon)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)

      Text(label)
        .fontSize(11)
        .fontColor(this.getDisplayIndex() === index ? '#0A6CFF' : '#7A8494')
        .fontWeight(this.getDisplayIndex() === index ? FontWeight.Medium : FontWeight.Regular)
    }
    .width(64)
    .height(48)
    .justifyContent(FlexAlign.Center)
    .borderRadius(12)
    .backgroundColor(this.getDisplayIndex() === index ? '#EAF2FF' : Color.Transparent)
  }

  private updateGestureTargetIndex(index: number, currentOffset: number): void {
    if (Math.abs(currentOffset) < this.getSwipeThresholdVp()) {
      this.gestureTargetIndex = this.selectedIndex;
      this.isGestureSwiping = false;
      return;
    }

    const targetIndex = currentOffset < 0 ? index + 1 : index - 1;
    this.gestureTargetIndex = this.clampTabIndex(targetIndex);
    this.isGestureSwiping = this.gestureTargetIndex !== this.selectedIndex;
  }

  private getDisplayIndex(): number {
    return this.isGestureSwiping ? this.gestureTargetIndex : this.selectedIndex;
  }

  private clampTabIndex(index: number): number {
    if (index < 0) {
      return 0;
    }
    if (index >= this.tabCount) {
      return this.tabCount - 1;
    }
    return index;
  }

  private getSwipeThresholdVp(): number {
    return Math.max(this.tabsContentWidthVp * this.swipeSwitchRatio, this.minSwipeThresholdVp);
  }

  private parseAreaLength(value: Length, fallback: number): number {
    if (typeof value === 'number') {
      return value > 0 ? value : fallback;
    }

    if (typeof value === 'string') {
      const parsedValue = Number.parseFloat(value);
      return Number.isNaN(parsedValue) || parsedValue <= 0 ? fallback : parsedValue;
    }

    return fallback;
  }
}
