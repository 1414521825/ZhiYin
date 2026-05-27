import { ChatViewState } from '../models/ViewStates';
import { MockLearningRepository } from '../repositories/MockLearningRepository';

export class ChatViewModel {
  private repository: MockLearningRepository = new MockLearningRepository();

  getInitialState(): ChatViewState {
    return {
      messages: this.repository.getChatMessages(),
      quickActions: this.repository.getQuickActions(),
      draft: ''
    };
  }

  updateDraft(state: ChatViewState, draft: string): ChatViewState {
    return {
      messages: state.messages,
      quickActions: state.quickActions,
      draft
    };
  }
}
