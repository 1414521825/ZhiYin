import { ChatMessage, DailyTask } from './LearningModels';

export interface LoginViewState {
  phone: string;
  code: string;
  canSubmit: boolean;
  hint: string;
}

export interface OnboardingViewState {
  learningGoal: string;
  targetPeriod: string;
  repositoryUrl: string;
  tokenStatus: string;
}

export interface TodayViewState {
  checkInDays: number;
  encouragement: string;
  generatedAt: string;
  updatedAt: string;
  tasks: DailyTask[];
}

export interface ChatViewState {
  messages: ChatMessage[];
  quickActions: string[];
  draft: string;
}

export interface ReviewViewState {
  syncedAt: string;
  branch: string;
  latestCommitHash: string;
  summary: string;
  missingPoints: string[];
  suggestions: string[];
  activity: number[];
}

export interface SettingsViewState {
  learningGoal: string;
  dailyAvailableMinutes: number;
  morningReminderTime: string;
  nightReviewTime: string;
  repositoryUrl: string;
  repositoryAuthStatus: string;
}
