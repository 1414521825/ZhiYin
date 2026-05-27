import { ReviewViewState } from '../models/ViewStates';
import { ReviewViewModel } from '../viewmodels/ReviewViewModel';

@ComponentV2
export struct ReviewPage {
  private viewModel: ReviewViewModel = new ReviewViewModel();
  @Local private state: ReviewViewState = this.viewModel.getInitialState();

  build() {
    Scroll() {
      Column({ space: 18 }) {
        Text('知识复盘')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Column({ space: 8 }) {
          this.infoLine('最后同步', this.state.syncedAt)
          this.infoLine('当前分支', this.state.branch)
          this.infoLine('最新提交', this.state.latestCommitHash)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)

        Column({ space: 12 }) {
          Text('AI 诊断报告')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text(this.state.summary)
            .fontSize(14)
            .fontColor('#3A4250')
            .width('100%')

          this.textList('遗漏知识点', this.state.missingPoints)
          this.textList('优化建议', this.state.suggestions)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)

        Column({ space: 12 }) {
          Text('近 30 天学习活跃度')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.state.activity, (value: number, index: number) => {
              Text('')
                .width(18)
                .height(18)
                .margin({ right: 6, bottom: 6 })
                .borderRadius(4)
                .backgroundColor(this.activityColor(value))
            }, (value: number, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  private infoLine(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(13)
        .fontColor('#7A8494')
      Blank()
      Text(value)
        .fontSize(13)
        .fontColor('#1F2329')
    }
    .width('100%')
  }

  @Builder
  private textList(title: string, items: string[]) {
    Column({ space: 6 }) {
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      ForEach(items, (item: string) => {
        Text(`- ${item}`)
          .fontSize(13)
          .fontColor('#5F6673')
          .width('100%')
      }, (item: string) => item)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  private activityColor(value: number): string {
    if (value >= 4) {
      return '#216E39';
    }
    if (value === 3) {
      return '#30A14E';
    }
    if (value === 2) {
      return '#40C463';
    }
    if (value === 1) {
      return '#9BE9A8';
    }
    return '#EBEDF0';
  }
}
