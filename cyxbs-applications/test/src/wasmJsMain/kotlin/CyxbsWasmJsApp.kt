import androidx.compose.material.MaterialTheme
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.window.ComposeViewport
import com.cyxbs.pages.login.ui.LoginCompose
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
      LoginCompose()
    }
  }
}