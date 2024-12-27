package rule

import org.gradle.api.Project
import java.io.File

/**
 * 项目命名空间检查，主要用于新建项目的时候没有按规范写好模块包名
 *
 * @author 985892345
 * 2022/12/20 17:42
 */
object ModuleNamespaceCheckRule : AndroidProjectChecker.ICheckRule {

  /**
   * 得到正确的 namespace
   */
  fun getCorrectNamespace(project: Project): String {
    if (project.name == "lib_common") {
      // lib_common 未迁移，这里特殊处理
      return "com.mredrock.cyxbs.common"
    }
    return "com${project.path.replace(":", ".").replace("-", ".")}"
  }
  
  override fun onConfig(project: Project) {
    if (project.name == "lib_common") {
      return // lib_common 未迁移，这里特殊处理，不进行检查
    }
    val namespace = getCorrectNamespace(project)
    val androidMainKotlinFile = project.projectDir
      .resolve("src")
      .resolve("androidMain")
      .resolve("kotlin")
    val androidMainKotlinCodeFile = androidMainKotlinFile.resolve(namespace.replace(".", File.separator))
    if (androidMainKotlinFile.list().isNullOrEmpty()) {
      // 如果都不存在，则应该是新模块，自动帮他创建文件夹
      androidMainKotlinCodeFile.mkdirs()
    } else if (!androidMainKotlinCodeFile.exists()) {
      val rule = """
        你当前 ${project.name} 模块的包名应该改为：$namespace
        ${project.projectDir}
        
      """.trimIndent()
      throw RuntimeException("${project.name} 模块包名错误！" + rule)
    }
  }
}