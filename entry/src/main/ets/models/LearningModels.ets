export enum TaskStatus {
  Pending = 'PENDING',
  InProgress = 'IN_PROGRESS',
  Done = 'DONE',
  Skipped = 'SKIPPED'
}

export interface DailyTask {
  taskId: string;
  title: string;
  status: TaskStatus;
  durationMinutes: number;
}

export interface TodayPlan {
  checkInDays: number;
  encouragement: string;
  generatedAt: string;
  updatedAt: string;
  tasks: DailyTask[];
}

export interface ChatMessage {
  messageId: string;
  role: 'USER' | 'ASSISTANT';
  content: string;
  createdAt: string;
}

export interface ReviewReport {
  syncedAt: string;
  branch: string;
  latestCommitHash: string;
  summary: string;
  missingPoints: string[];
  suggestions: string[];
  activity: number[];
}

export interface UserSettings {
  learningGoal: string;
  dailyAvailableMinutes: number;
  morningReminderTime: string;
  nightReviewTime: string;
  repositoryUrl: string;
  repositoryAuthStatus: string;
}
