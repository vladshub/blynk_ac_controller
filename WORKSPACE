load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

new_git_repository(
    name = "blynk",
    remote = "https://github.com/blynkkk/blynk-library",
    # https://github.com/blynkkk/blynk-library/releases/download/v0.5.4/Blynk_Release_v0.5.4.zip
    tag = "v0.5.4",
    build_file_content = """
cc_library(
    name = "blynk-lib",
    srcs = [
        "src/utility/BlynkDebug.cpp", 
        "src/utility/BlynkHandlers.cpp", 
        "src/utility/BlynkTimer.cpp",
    ],
    hdrs = glob(["src/*.h", "src/**/*.h", "linux/*.h"]),
    copts = [
        "-Iexternal/blynk/src",
        "-Iexternal/blynk/linux"
    ],
    linkopts = ["-pthread"],
    visibility = ["//visibility:public"],
    defines = ["LINUX"]
)
""",
)
