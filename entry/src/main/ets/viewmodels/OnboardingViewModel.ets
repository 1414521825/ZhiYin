import { OnboardingViewState } from '../models/ViewStates';
import { MockLearningRepository } from '../repositories/MockLearningRepository';

export class OnboardingViewModel {
  private repository: MockLearningRepository = new MockLearningRepository();

  getInitialState(): OnboardingViewState {
    const settings = this.repository.getSettings();
    return {
      learningGoal: settings.learningGoal,
      targetPeriod: '30 天',
      repositoryUrl: settings.repositoryUrl,
      tokenStatus: settings.repositoryAuthStatus
    };
  }
}
