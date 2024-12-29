import org.gradle.api.Project

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/21
 */
object Multiplatform {
  fun enableIOS(project: Project): Boolean {
    return project.rootProject.properties["cyxbs.multiplatform.ios"] == "true"
  }

  fun enableWasm(project: Project): Boolean {
    return project.rootProject.properties["cyxbs.multiplatform.wasm"] == "true"
  }

  fun enableDesktop(project: Project): Boolean {
    return project.rootProject.properties["cyxbs.multiplatform.desktop"] == "true"
  }

  // 运行 Android 的任务
  fun runAndroid(project: Project): Boolean {
    return project.gradle.startParameter.taskNames.any {
      it.contains("assembleRelease")
          || it.contains("assembleDebug")
          || it == "channelRelease"
          || it == "channelDebug"
          || it == "cyxbsRelease"
    }
  }

  // 运行 Desktop 的任务
  fun runDesktop(project: Project): Boolean {
    return project.gradle.startParameter.taskNames.any {
      it.contains("desktop")
          || it.contains("package")
    }
  }

  // 运行 WasmJs 的任务
  fun runWasmJs(project: Project): Boolean {
    return project.gradle.startParameter.taskNames.any {
      it.contains("wasmJs")
    }
  }
}