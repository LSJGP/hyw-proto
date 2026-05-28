# hyw-proto

全项目唯一的 `.proto` 定义。`hyw-sim`、`hyw-planner`、`hyw-grading` 通过 Bazel 引用本仓。

---

## `proto/sim/` — `package hyw_sim.proto`

### `common.proto`

| 定义 | 含义 |
|------|------|
| `Vec3` | 三维点 (x, y, z) |
| `Pose2D` | 平面位姿 (x, y, yaw) |
| `Bbox2D` | 轴对齐包围盒 |
| `WorldOffset` | 场景全局坐标平移到局部原点的偏移 |

### `scenario.proto`

| 定义 | 含义 |
|------|------|
| `TrackState` | 单帧轨迹点：位姿、速度、尺寸、是否有效 |
| `Track` | 一条交通参与者轨迹（id、类型、是否 SDC、逐帧 states） |
| `ScenarioStats` | 场景统计：地图要素数量、时长、车辆类型计数等 |
| `ScenarioMeta` | 场景元信息：来源、id、world_offset、起终点、包围盒、统计 |
| `DynamicObjects` | 动态层：时间戳列表、当前帧索引、全部 tracks |
| `ScenarioBundle` | meta + dynamic 打包 |

### `map.proto`

| 定义 | 含义 |
|------|------|
| `BoundarySegment` | 车道边界线段（起止索引、类型） |
| `LaneNeighbor` | 相邻车道及共享边界 |
| `Lane` | 车道：中心线、限速、进出车道、左右边界与邻居 |
| `RoadLine` | 车道标线 |
| `RoadEdge` | 道路边缘 |
| `Crosswalk` | 人行横道多边形 |
| `StopSign` | 停止标志位置及关联车道 |
| `Driveway` | 出入口区域 |
| `SpeedBump` | 减速带区域 |
| `MapFeatureCounts` | 各类地图要素数量 |
| `StaticMap` | 完整静态地图（含上述全部要素） |

### `runtime.proto`

| 定义 | 含义 |
|------|------|
| `ReferencePoint` | 参考线上的点：位姿、速度、是否有效 |
| `VehicleParams` | 自车物理参数：尺寸、轴距、加减速与转向极限 |
| `VehicleState` | 自车状态：位姿、速度、加速度、前轮角 |
| `PlanCommand` | 一步控制指令：目标加速度、转向角、期望速度 |
| `NpcSnapshot` | 某一时刻单个 NPC 的状态快照 |
| `RoadContext` | 自车相对道路的距离（左右边界、路沿、最近车道、横向偏移） |
| `TrajectoryPoint` | 规划轨迹上的一点 |
| `PlannerTrajectory` | 规划轨迹点序列 |
| `PlannerConfig` | 轨迹生成配置：时域、点时间步 |
| `PlannerObservation` | 规划器单步输入：帧号、时间、ego、NPC 列表、道路上下文 |
| `FrameRecord` | 仿真单帧输出：ego、指令、NPC、道路、规划轨迹 |
| `WorldConfig` | 仿真配置：dt、最长时长、初速 |
| `PlannerInputs` | 规划器启动参数：目标点、期望速度、参考线、车辆参数 |
| `MapRouteResult` | 地图路由结果：参考线、限速、途经 lane id |

---

## `proto/grading/` — `package grading_mini.proto`

### `scene.proto`

| 定义 | 含义 |
|------|------|
| `Vec3` | 三维点（评分侧） |
| `BoundarySegment` | 车道边界段 |
| `Lane` | 车道中心线与边界 |
| `RoadLine` | 车道线 |
| `RoadEdge` | 路沿 |
| `Crosswalk` | 人行横道 |
| `SceneMap` | 评分用的场景地图子集 |

### `metric_input.proto`

| 定义 | 含义 |
|------|------|
| `VehicleState` | 自车状态 |
| `PlanningCommand` | 规划期望速度 |
| `CollisionEvent` | 碰撞事件：对象、类型、责任、是否豁免、相对速度等 |
| `NpcState` | NPC 状态 |
| `RoadContext` | 道路距离上下文 |
| `EgoVehicleParams` | 自车尺寸参数 |
| `MetricFrameInput` | **每帧评分输入**（自车、规划、碰撞、NPC、地图、道路） |

### `metric_output.proto`

| 定义 | 含义 |
|------|------|
| `MetricFrameOutput` | 单帧单指标输出（bool / double / 自定义 Any） |
| `MetricSummary` | 单个 metric 汇总：是否通过、说明 |
| `GradingReport` | 整场评分报告：总通过与否、各 metric 摘要 |

### `sim_log.proto`

| 定义 | 含义 |
|------|------|
| `SimLog` | 仿真日志：来源 + 按时间排列的 `MetricFrameInput` 序列 |

### `grading_run_config.proto`

| 定义 | 含义 |
|------|------|
| `MetricInstance` | 要运行的一个 metric：名称 + JSON 参数字符串 |
| `GradingRunConfig` | 一次评分运行配置：速度上限、metric 列表、日志等级 |

### `metrics/example_metric.proto`

| 定义 | 含义 |
|------|------|
| `SpeedChecker` | 超速检查参数 |
| `PlanningLimitCheckerConfig` | 规划期望速度上限 |
| `SpeedCheckerCustomInfo` | 超速检查逐帧附加信息 |

### `metrics/safety_metric.proto`

| 定义 | 含义 |
|------|------|
| `LaneDepartureCheckerConfig` | 偏离车道/路沿的最小净空 |
| `DrivableAreaCheckerConfig` | 可行驶区域净空（是否只检查中心点） |

---

## `proto/planner/` — `package hyw_planner.proto`

| 定义 | 含义 |
|------|------|
| `PlannerService` | gRPC 服务：ListPlanners / CreateSession / Plan / CloseSession / Health |
| `CreateSessionRequest` | 创建 planner 实例（含 `PlannerInputs`） |
| `PlanRequest` | 单步规划输入（session + `PlannerObservation`） |
| `PlanResponse` | 单步规划输出（`PlannerTrajectory`） |

Bazel target：`//proto/planner:planner_cc_grpc`（C++ message + gRPC stub/server）。
