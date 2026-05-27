import { ReviewViewState } from '../models/ViewStates';
import { MockLearningRepository } from '../repositories/MockLearningRepository';

export class ReviewViewModel {
  private repository: MockLearningRepository = new MockLearningRepository();

  getInitialState(): ReviewViewState {
    const report = this.repository.getReviewReport();
    return {
      syncedAt: report.syncedAt,
      branch: report.branch,
      latestCommitHash: report.latestCommitHash,
      summary: report.summary,
      missingPoints: report.missingPoints,
      suggestions: report.suggestions,
      activity: report.activity
    };
  }
}
