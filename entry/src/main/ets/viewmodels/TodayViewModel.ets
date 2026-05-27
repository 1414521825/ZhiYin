import { TaskStatus } from '../models/LearningModels';
import { TodayViewState } from '../models/ViewStates';
import { MockLearningRepository } from '../repositories/MockLearningRepository';

export class TodayViewModel {
  private repository: MockLearningRepository = new MockLearningRepository();

  getInitialState(): TodayViewState {
    const plan = this.repository.getTodayPlan();
    return {
      checkInDays: plan.checkInDays,
      encouragement: plan.encouragement,
      generatedAt: plan.generatedAt,
      updatedAt: plan.updatedAt,
      tasks: plan.tasks
    };
  }

  getTaskStatusText(status: TaskStatus): string {
    if (status === TaskStatus.Done) {
      return '已完成';
    }
    if (status === TaskStatus.InProgress) {
      return '进行中';
    }
    if (status === TaskStatus.Skipped) {
      return '已跳过';
    }
    return '待开始';
  }
}
