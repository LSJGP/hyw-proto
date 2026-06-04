"""Pin gRPC transitive deps for Bazel 7.

grpc_deps() defaults to rules_apple 0.32.0, which breaks on Bazel 7 even on Linux
because grpc_build_system.bzl loads Apple rules at analysis time.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def hyw_grpc_deps():
    if "platforms" not in native.existing_rules():
        http_archive(
            name = "platforms",
            sha256 = "218efe8ee736d26a3572663b374a253c012b716d8af0c07e842e82f238a0a7ee",
            urls = ["https://github.com/bazelbuild/platforms/releases/download/0.0.10/platforms-0.0.10.tar.gz"],
        )
    if "build_bazel_apple_support" not in native.existing_rules():
        http_archive(
            name = "build_bazel_apple_support",
            sha256 = "73c8dc6cdd7cea87956db9279a69c9e68bd2a5ec6a6a507e36d6e2d7da4d71a4",
            urls = ["https://github.com/bazelbuild/apple_support/releases/download/1.21.1/apple_support.1.21.1.tar.gz"],
        )
    if "build_bazel_rules_swift" not in native.existing_rules():
        http_archive(
            name = "build_bazel_rules_swift",
            sha256 = "28db894977ac51c8f3ab7c6dc9d655a85510366734e900b3c5302ce1ed91256c",
            urls = ["https://github.com/bazelbuild/rules_swift/releases/download/2.4.0/rules_swift.2.4.0.tar.gz"],
        )
    if "build_bazel_rules_apple" not in native.existing_rules():
        http_archive(
            name = "build_bazel_rules_apple",
            sha256 = "70b0fb2aec1055c978109199bf58ccb5008aba8e242f3305194045c271ca3cae",
            urls = ["https://github.com/bazelbuild/rules_apple/releases/download/4.0.0/rules_apple.4.0.0.tar.gz"],
        )
