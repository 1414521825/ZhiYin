import { LoginPage } from './LoginPage';
import { MainTabPage } from './MainTabPage';
import { OnboardingPage } from './OnboardingPage';

enum AppStage {
  Login = 'login',
  Onboarding = 'onboarding',
  Main = 'main'
}

@Entry
@ComponentV2
struct Index {
  @Local private appStage: AppStage = AppStage.Login;

  build() {
    Navigation() {
      if (this.appStage === AppStage.Login) {
        LoginPage({
          onLoginSuccess: () => {
            this.appStage = AppStage.Onboarding;
          }
        })
      } else if (this.appStage === AppStage.Onboarding) {
        OnboardingPage({
          onComplete: () => {
            this.appStage = AppStage.Main;
          }
        })
      } else {
        MainTabPage()
      }
    }
    .title('知音')
    .hideTitleBar(this.appStage === AppStage.Main)
    .height('100%')
    .width('100%')
  }
}
