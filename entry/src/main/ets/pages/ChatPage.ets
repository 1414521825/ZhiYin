import { ChatMessage } from '../models/LearningModels';
import { ChatViewState } from '../models/ViewStates';
import { ChatViewModel } from '../viewmodels/ChatViewModel';

@ComponentV2
export struct ChatPage {
  private viewModel: ChatViewModel = new ChatViewModel();
  @Local private state: ChatViewState = this.viewModel.getInitialState();

  build() {
    Column({ space: 12 }) {
      Column({ space: 4 }) {
        Text('AI 导师')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text('围绕今日计划、知识点和复盘结果提问')
          .fontSize(14)
          .fontColor('#5F6673')
          .width('100%')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.state.quickActions, (action: string) => {
          Button(action)
            .fontSize(12)
            .height(34)
            .margin({ right: 8, bottom: 8 })
        }, (action: string) => action)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })

      Scroll() {
        Column({ space: 12 }) {
          ForEach(this.state.messages, (message: ChatMessage) => {
            this.messageBubble(message)
          }, (message: ChatMessage) => message.messageId)
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)

      Row({ space: 10 }) {
        TextInput({ placeholder: '输入问题或计划调整需求', text: this.state.draft })
          .layoutWeight(1)
          .height(44)
          .onChange((value: string) => {
            this.state = this.viewModel.updateDraft(this.state, value);
          })

        Button('发送')
          .height(44)
          .enabled(this.state.draft.length > 0)
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 14 })
      .backgroundColor('#F7F8FA')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  private messageBubble(message: ChatMessage) {
    Row() {
      if (message.role === 'USER') {
        Blank()
        Text(message.content)
          .fontSize(14)
          .fontColor(Color.White)
          .padding(12)
          .backgroundColor('#0A6CFF')
          .borderRadius(8)
          .constraintSize({ maxWidth: '78%' })
      } else {
        Text(message.content)
          .fontSize(14)
          .fontColor('#1F2329')
          .padding(12)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .constraintSize({ maxWidth: '78%' })
        Blank()
      }
    }
    .width('100%')
  }
}
