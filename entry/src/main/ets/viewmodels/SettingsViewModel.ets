import { SettingsViewState } from '../models/ViewStates';
import { MockLearningRepository } from '../repositories/MockLearningRepository';

export class SettingsViewModel {
  private repository: MockLearningRepository = new MockLearningRepository();

  getInitialState(): SettingsViewState {
    const settings = this.repository.getSettings();
    return {
      learningGoal: settings.learningGoal,
      dailyAvailableMinutes: settings.dailyAvailableMinutes,
      morningReminderTime: settings.morningReminderTime,
      nightReviewTime: settings.nightReviewTime,
      repositoryUrl: settings.repositoryUrl,
      repositoryAuthStatus: settings.repositoryAuthStatus
    };
  }
}
