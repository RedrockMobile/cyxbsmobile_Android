import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Text
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.launchApplication
import androidx.compose.ui.window.rememberWindowState
import com.cyxbs.components.utils.coroutine.runApp
import com.g985892345.provider.cyxbsmobile.cyxbsapplications.test.TestKtProviderInitializer

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/29
 */

fun main() = runApp {
  TestKtProviderInitializer.tryInitKtProvider()
  launchApplication {
    val width = 1000
    val height = 600
    Window(
      onCloseRequest = ::exitApplication,
      title = "桌上重邮",
      state = rememberWindowState(width = width.dp, height = height.dp),
//      resizable = false,
    ) {
      remember {
//        this.window.minimumSize = java.awt.Dimension(width, height)
      }
      Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Text(text = "桌上重邮", fontSize = 20.sp)
      }
    }
  }
}