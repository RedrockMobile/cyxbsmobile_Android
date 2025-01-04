import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.ComposeViewport
import com.g985892345.provider.cyxbsmobile.cyxbsapplications.test.TestKtProviderInitializer
import kotlinx.browser.document

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/29
 */

@OptIn(ExperimentalComposeUiApi::class)
fun main() {
  TestKtProviderInitializer.tryInitKtProvider()
  ComposeViewport(
    viewportContainer = document.getElementById("compose")!!,
  ) {
    MaterialTheme(
      typography = createTypography(),
    ) {
      Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Text(text = "网上重邮", fontSize = 20.sp)
      }
    }
  }
}