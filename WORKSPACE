new_git_repository(
    name = "blynk",
    remote = "https://github.com/blynkkk/blynk-library.git",
    build_file_content = """
        cc_library(
            name = "blynk-lib",
            srcs = ["src/utility/BlynkDebug.cpp", "src/utility/BlynkHandlers.cpp", "src/utility/BlynkTimer.cpp"],
            includes = ["src", "linux"],
            visibility = ["//visibility:public"],
        )
    """,
)
