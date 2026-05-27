import { ChatMessage, ReviewReport, TaskStatus, TodayPlan, UserSettings } from '../models/LearningModels';

export class MockLearningRepository {
  getTodayPlan(): TodayPlan {
    return {
      checkInDays: 6,
      encouragement: '今天聚焦 ArkUI 页面框架，把学习节奏搭稳。',
      generatedAt: '08:00',
      updatedAt: '08:20',
      tasks: [
        {
          taskId: 'task-arkui-navigation',
          title: '梳理 Navigation 与 Tabs 的页面边界',
          status: TaskStatus.Done,
          durationMinutes: 30
        },
        {
          taskId: 'task-mvvm-shell',
          title: '搭建 MVVM 目录与主页面框架',
          status: TaskStatus.InProgress,
          durationMinutes: 60
        },
        {
          taskId: 'task-review-notes',
          title: '补充今日实现笔记并提交到 Git',
          status: TaskStatus.Pending,
          durationMinutes: 45
        },
        {
          taskId: 'task-self-check',
          title: '复查页面状态与 Mock 数据边界',
          status: TaskStatus.Pending,
          durationMinutes: 20
        }
      ]
    };
  }

  getChatMessages(): ChatMessage[] {
    return [
      {
        messageId: 'chat-1',
        role: 'ASSISTANT',
        content: '早上好，今天建议先完成客户端页面框架，再做复盘笔记。',
        createdAt: '08:05'
      },
      {
        messageId: 'chat-2',
        role: 'USER',
        content: '如果时间不够，今天最该优先做什么？',
        createdAt: '10:20'
      },
      {
        messageId: 'chat-3',
        role: 'ASSISTANT',
        content: '优先完成主导航和四个 Tab 的可运行框架，视觉细节可以后置。',
        createdAt: '10:21'
      }
    ];
  }

  getQuickActions(): string[] {
    return ['调整今日剩余计划', '解释 ArkUI 状态管理', '针对昨晚复盘提问'];
  }

  getReviewReport(): ReviewReport {
    return {
      syncedAt: '昨天 23:00',
      branch: 'main',
      latestCommitHash: '32ef510',
      summary: '昨日完成了 PRD 与 MVVM 约束文档，客户端实现尚未开始。',
      missingPoints: ['缺少可运行页面框架', '缺少 Mock 数据入口', '尚未验证 Navigation 与 Tabs 组合'],
      suggestions: ['先完成 Phase 1 页面壳', '保持 Mock 数据在 Repository 层', '提交前在 DevEco Studio 中构建验证'],
      activity: [1, 0, 2, 1, 3, 0, 2, 4, 1, 0, 2, 3, 1, 2, 0, 4, 2, 1, 3, 0, 1, 2, 3, 1, 0, 2, 4, 2, 1, 3]
    };
  }

  getSettings(): UserSettings {
    return {
      learningGoal: '一个月内掌握鸿蒙原生应用开发',
      dailyAvailableMinutes: 90,
      morningReminderTime: '08:00',
      nightReviewTime: '23:00',
      repositoryUrl: 'https://gitee.com/example/study-notes',
      repositoryAuthStatus: '已授权'
    };
  }
}
