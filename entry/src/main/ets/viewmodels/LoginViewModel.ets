import { LoginViewState } from '../models/ViewStates';

export class LoginViewModel {
  getInitialState(): LoginViewState {
    return {
      phone: '',
      code: '',
      canSubmit: false,
      hint: 'Phase 1 使用本地模拟登录，不发送真实验证码。'
    };
  }

  updatePhone(state: LoginViewState, phone: string): LoginViewState {
    return this.buildState(phone, state.code);
  }

  updateCode(state: LoginViewState, code: string): LoginViewState {
    return this.buildState(state.phone, code);
  }

  private buildState(phone: string, code: string): LoginViewState {
    return {
      phone,
      code,
      canSubmit: phone.length >= 11 && code.length >= 4,
      hint: 'Phase 1 使用本地模拟登录，不发送真实验证码。'
    };
  }
}
