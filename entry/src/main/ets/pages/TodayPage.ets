import { DailyTask, TaskStatus } from '../models/LearningModels';
import { TodayViewState } from '../models/ViewStates';
import { TodayViewModel } from '../viewmodels/TodayViewModel';

@ComponentV2
export struct TodayPage {
  private viewModel: TodayViewModel = new TodayViewModel();
  @Local private state: TodayViewState = this.viewModel.getInitialState();

  build() {
    Scroll() {
      Column({ space: 18 }) {
        Column({ space: 8 }) {
          Text('今日计划')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text(this.state.encouragement)
            .fontSize(14)
            .fontColor('#5F6673')
            .width('100%')
        }
        .width('100%')

        Row() {
          this.statItem('连续打卡', `${this.state.checkInDays} 天`)
          this.statItem('生成时间', this.state.generatedAt)
          this.statItem('最近调整', this.state.updatedAt)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 12 }) {
          ForEach(this.state.tasks, (task: DailyTask) => {
            this.taskRow(task)
          }, (task: DailyTask) => task.taskId)
        }
        .width('100%')

        Button('提前结束今日学习并开始复盘')
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
  private statItem(label: string, value: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(11)
        .fontColor('#7A8494')
    }
    .width('31%')
    .height(72)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }

  @Builder
  private taskRow(task: DailyTask) {
    Row({ space: 12 }) {
      Text(this.viewModel.getTaskStatusText(task.status))
        .fontSize(12)
        .fontColor(this.statusColor(task.status))
        .width(56)

      Column({ space: 5 }) {
        Text(task.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2329')
          .width('100%')

        Text(`${task.durationMinutes} 分钟`)
          .fontSize(12)
          .fontColor('#7A8494')
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }

  private statusColor(status: TaskStatus): string {
    if (status === TaskStatus.Done) {
      return '#1F8F4D';
    }
    if (status === TaskStatus.InProgress) {
      return '#0A6CFF';
    }
    if (status === TaskStatus.Skipped) {
      return '#9AA3B2';
    }
    return '#7A8494';
  }
}
