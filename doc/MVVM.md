# HarmonyOS 客户端 MVVM 约束

本文档定义当前 HarmonyOS NEXT 客户端工程的 MVVM 分层依据、各层职责、访问关系和代码组织规则。后续新增 ArkTS/ArkUI 代码时应遵循本约束。

## 一、分层依据

MVVM 的核心目标是把“界面怎么画”“用户操作怎么改变状态”“数据从哪里来”拆开，避免 ArkUI 页面同时承担 UI、业务、网络和缓存职责。

ArkUI 是声明式 UI，更适合让页面绑定状态并响应状态变化。页面状态和交互流程应集中在 ViewModel，数据来源由 Repository 和 Service 屏蔽。这样 Phase 1 使用 Mock 数据、后续切换真实后端时，尽量不需要改动 View。

## 二、依赖方向

依赖只能从上层指向下层：

```text
View(Page/Component)
        |
        v
ViewModel
        |
        v
Repository
        |
        v
Service / LocalStorage / Remote API

Model / DTO / ViewState 可按职责被相关层引用
```

硬性规则：

- `View` 可以调用 `ViewModel`。
- `ViewModel` 可以调用 `Repository`。
- `Repository` 可以调用 `Service`。
- `Service` 不知道上层存在。
- 下层不得反向依赖上层。
- 如果下层需要通知上层，返回结果、状态或错误，由上层决定如何处理。

## 三、各层职责与可访问性

### 3.1 View

对应 ArkUI 页面和组件，例如 `TodayPage.ets`、`TaskCard.ets`。

职责：

- 负责 UI 布局、样式和组件组合。
- 绑定 ViewModel 暴露的页面状态。
- 将点击、输入、刷新、导航等事件转发给 ViewModel 或路由入口。

禁止：

- 不直接请求接口。
- 不直接读写缓存。
- 不直接写复杂业务判断。
- 不直接拼装后端数据。
- 不直接放置 Mock 数据。

可访问：

- 可以访问对应的 `ViewModel`。
- 可以访问 UI 常量、展示格式化工具和展示用类型。
- 不直接访问 `Repository` 或 `Service`。

### 3.2 ViewModel

对应页面状态和交互逻辑，例如 `TodayViewModel.ets`。

职责：

- 管理页面状态：loading、error、empty、content。
- 响应 View 事件，例如 `loadTodayPlan()`、`completeTask()`。
- 调用 Repository 获取或更新数据。
- 将业务数据转换成页面容易绑定的 `ViewState`。

禁止：

- 不直接写 HTTP 细节。
- 不关心接口 URL、Header、Token 拼接。
- 不依赖 ArkUI 页面组件。

可访问：

- 可以访问 `Repository`。
- 可以访问 `Model` 和 `ViewState`。
- 不访问 `View`。

### 3.3 Repository

对应业务数据访问入口，例如 `PlanRepository.ets`、`ChatRepository.ets`。

职责：

- 提供面向业务的数据方法，例如获取今日计划、更新任务状态。
- 屏蔽数据来源：Mock、远程 API、本地缓存。
- 决定数据从 remote、local 或组合来源获取。
- 将 Service 返回的数据整理成业务 Model。

禁止：

- 不处理 UI 状态。
- 不知道页面 loading、error、empty 如何展示。
- 不依赖 ViewModel 或 View。

可访问：

- 可以访问 `Service`。
- 可以访问 `Model` 和接口 DTO。
- 不访问 `ViewModel` 或 `View`。

### 3.4 Service

对应底层适配，例如 `PlanApiService.ets`、`AuthApiService.ets`、`StorageService.ets`。

职责：

- 处理 HTTP 请求、本地存储、系统能力等底层能力。
- 管理接口路径、请求参数、响应解析和错误码初步转换。
- 封装后端 API、缓存、设备 API 的调用细节。

禁止：

- 不做页面业务决策。
- 不返回直接绑定 UI 的复杂页面状态。
- 不依赖 Repository 以上的层。

可访问：

- 可以访问底层 SDK、网络库、系统 API。
- 可以访问 DTO 类型。
- 不访问 `Repository`、`ViewModel` 或 `View`。

### 3.5 Model / DTO / ViewState

这三类是数据结构，不是业务流程层。

- `DTO`：后端接口原始结构，主要在 Service 和 Repository 使用。
- `Model`：客户端业务实体，可被 ViewModel、Repository、Service 按职责引用。
- `ViewState`：页面展示状态，主要给 View 和 ViewModel 使用，不传入 Repository 或 Service。

规则：

- View 尽量绑定 `ViewState`，不要直接绑定后端 DTO。
- Repository 负责将 DTO 转换成 Model。
- ViewModel 负责将 Model 转换成 ViewState。

## 四、推荐目录

```text
entry/src/main/ets/pages
entry/src/main/ets/viewmodels
entry/src/main/ets/models
entry/src/main/ets/repositories
entry/src/main/ets/services
entry/src/main/ets/common
```

目录含义：

- `pages`：页面级 View 和页面私有组件。
- `viewmodels`：页面或业务场景对应的 ViewModel。
- `models`：业务实体、DTO、ViewState、枚举类型。
- `repositories`：业务数据访问接口和实现。
- `services`：HTTP、缓存、系统能力等底层适配。
- `common`：通用常量、工具、基础类型。

## 五、命名规则

- 页面：`TodayPage.ets`、`ReviewPage.ets`。
- 组件：`TaskCard.ets`、`HeatmapGrid.ets`。
- ViewModel：`TodayViewModel.ets`、`ChatViewModel.ets`。
- Repository：`PlanRepository.ets`、`ChatRepository.ets`。
- Service：`PlanApiService.ets`、`AuthApiService.ets`。
- Model：`DailyPlan.ets`、`DailyTask.ets`。
- DTO：`DailyPlanDTO.ets`。
- ViewState：`TodayViewState.ets`。

## 六、Mock 与后端切换规则

Phase 1 可以使用 Mock 数据，但 Mock 数据必须通过 Repository 提供。

推荐做法：

- View 调用 ViewModel。
- ViewModel 调用 `PlanRepository`。
- Phase 1 由 `MockPlanRepository` 返回固定数据。
- 接入后端后替换为 `RemotePlanRepository` 或在 Repository 内切换数据源。
- View 不因数据来源变化而修改。

禁止做法：

- 在 ArkUI 页面里直接写 Mock 数组。
- 在 ViewModel 里散落大量临时接口假数据。
- 为了演示页面绕过 Repository 直接调用 Service。

## 七、最小判断标准

新增或修改客户端代码时，至少满足以下检查：

- 页面是否只负责 UI 和事件转发。
- 页面状态是否集中在 ViewModel。
- 数据访问是否经过 Repository。
- HTTP、缓存、系统能力是否封装在 Service。
- Mock 数据是否没有出现在页面中。
- 是否没有出现下层反向依赖上层。
