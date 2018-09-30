#denote the name of the folder where to compile BLYNK and set a variable
set(BLYNK_PREFIX blynk)

# set a variable to point to the URL of the BLYNK source.
set(BLYNK_GIT_REPOSITORY https://github.com/blynkkk/blynk-library.git)

# set the git tag to use for blynk
set(BLYNK_GIT_TAG v0.5.4)

ExternalProject_Add(${BLYNK_PREFIX}
    PREFIX ${BLYNK_PREFIX}
    GIT_REPOSITORY ${BLYNK_GIT_REPOSITORY}
    GIT_TAG ${BLYNK_GIT_TAG}
    CONFIGURE_COMMAND ""
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1
    LOG_BUILD 1
)

ExternalProject_Get_Property(${BLYNK_PREFIX} SOURCE_DIR)
message(STATUS "Source directory of ${BLYNK_PREFIX} - ${SOURCE_DIR}")
# set the include directory variable and include it
set(BLYNK_SRC_DIR ${SOURCE_DIR}/src)
set(BLYNK_LINUX_DIR ${SOURCE_DIR}/linux)
set(BLYNK_SOURCE ${BLYNK_SRC_DIR}/utility/BlynkDebug.cpp ${BLYNK_SRC_DIR}/utility/BlynkHandlers.cpp ${BLYNK_SRC_DIR}/utility/BlynkTimer.cpp)
