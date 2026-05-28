load("@rules_proto_grpc//cpp:defs.bzl", "cpp_grpc_library")

proto_library(
    name = "planner_service_proto",
    srcs = ["planner_service.proto"],
    deps = ["//proto/sim:runtime_proto"],
    visibility = ["//visibility:public"],
)

cpp_grpc_library(
    name = "planner_cc_grpc",
    protos = [":planner_service_proto"],
    deps = ["//proto/sim:runtime_cc_proto"],
    visibility = ["//visibility:public"],
)

# Message-only target for consumers that do not need gRPC stubs.
load("@rules_cc//cc:defs.bzl", "cc_proto_library")

cc_proto_library(
    name = "planner_service_cc_proto",
    deps = [":planner_service_proto"],
    visibility = ["//visibility:public"],
)
