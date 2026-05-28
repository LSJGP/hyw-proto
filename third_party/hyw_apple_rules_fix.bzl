"""Pin Apple Bazel rules to versions compatible with Bazel 7."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def hyw_apple_rules_fix():
    if "platforms" not in native.existing_rules():
        http_archive(
            name = "platforms",
            sha256 = "218efe8ee736d26a3572663b374a253c012b716d8af0c07e842e82f238a0a7ee",
            urls = ["https://github.com/bazelbuild/platforms/releases/download/0.0.10/platforms-0.0.10.tar.gz"],
        )
    if "build_bazel_rules_swift" not in native.existing_rules():
        http_archive(
            name = "build_bazel_rules_swift",
            sha256 = "9919ed1d8dae509645bfd380537ae6501528d8de971caebed6d5185b9970dc4d",
            urls = ["https://github.com/bazelbuild/rules_swift/releases/download/2.1.1/rules_swift.2.1.1.tar.gz"],
        )
    if "build_bazel_apple_support" not in native.existing_rules():
        http_archive(
            name = "build_bazel_apple_support",
            sha256 = "73c8dc6cdd7cea87956db9279a69c9e68bd2a5ec6a6a507e36d6e2d7da4d71a4",
            urls = ["https://github.com/bazelbuild/apple_support/releases/download/1.21.1/apple_support.1.21.1.tar.gz"],
        )
    if "build_bazel_rules_apple" not in native.existing_rules():
        http_archive(
            name = "build_bazel_rules_apple",
            sha256 = "b892911288715b354e05b9a6fe9009635f7155991f24f27e779fe80d435c92bc",
            urls = ["https://github.com/bazelbuild/rules_apple/releases/download/3.13.0/rules_apple.3.13.0.tar.gz"],
        )
