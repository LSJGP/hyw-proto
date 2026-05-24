# hyw-proto

**唯一**的 Protocol Buffers 定义来源。`hyw-grading` 与 `hyw-sim` 通过 Bazel `local_repository` 引用本仓，不得在各自仓库内再维护 `.proto` 副本。

## 布局

```
proto/
├── sim/       # package hyw_sim.proto
└── grading/   # package grading_mini.proto
```

## 校验与参考树同步

```bash
./scripts/verify_proto_sync.sh /path/to/hyw_grading   # 与旧单体仓逐字节对比
```

修改 `.proto` 时只改本仓，然后在 `hyw-grading` / `hyw-sim` 中重新 `bazel build`。
