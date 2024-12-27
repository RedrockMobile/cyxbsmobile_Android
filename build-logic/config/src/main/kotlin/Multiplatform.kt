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
}