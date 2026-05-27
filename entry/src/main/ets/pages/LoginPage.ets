import { LoginViewState } from '../models/ViewStates';
import { LoginViewModel } from '../viewmodels/LoginViewModel';

@ComponentV2
export struct LoginPage {
  @Event
  onLoginSuccess: () => void = () => {};
  private viewModel: LoginViewModel = new LoginViewModel();
  @Local private state: LoginViewState = this.viewModel.getInitialState();

  build() {
    Column({ space: 24 }) {
      Blank()
        .height(48)

      Column({ space: 10 }) {
        Text('知音')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)

        Text('AI 辅助学习规划与复盘')
          .fontSize(16)
          .fontColor('#5F6673')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Column({ space: 16 }) {
        TextInput({ placeholder: '请输入手机号', text: this.state.phone })
          .height(48)
          .type(InputType.PhoneNumber)
          .onChange((value: string) => {
            this.state = this.viewModel.updatePhone(this.state, value);
          })

        TextInput({ placeholder: '请输入验证码', text: this.state.code })
          .height(48)
          .type(InputType.Number)
          .onChange((value: string) => {
            this.state = this.viewModel.updateCode(this.state, value);
          })

        Button('模拟登录')
          .width('100%')
          .height(48)
          .enabled(this.state.canSubmit)
          .onClick(() => {
            this.onLoginSuccess();
          })

        Text(this.state.hint)
          .fontSize(12)
          .fontColor('#7A8494')
      }
      .width('100%')

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#F7F8FA')
  }
}
