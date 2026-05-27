## Phase 1 Notes

### Tabs 默认动画问题

#### 现象

在 Preview 中切换底部 Tabs 时，页面内容已经切换，但底部 Tab 栏选中态会稍后更新，观感上像是 Tab 栏存在延迟。

#### 当前判断

该现象与 `Tabs` 默认切换动画有关。给 `MainTabPage` 中的 `Tabs` 增加 `.animationDuration(0)` 后，页面内容与底部 Tab 栏选中态同步，延迟感消失。

#### 当前处理

Phase 1 暂时保留：

```typescript
.animationDuration(0)
```

这会禁用 Tabs 内容切换动画，使四个主功能区切换更直接、稳定。

#### 后续验证

- 在 DevEco Studio 真机或模拟器中验证是否仍有 Tab 栏选中态延迟。
- 如果真机无明显延迟，可以评估恢复较短动画，例如 `100` 或 `150`。
- 如果真机仍有延迟，继续保留 `.animationDuration(0)`。
