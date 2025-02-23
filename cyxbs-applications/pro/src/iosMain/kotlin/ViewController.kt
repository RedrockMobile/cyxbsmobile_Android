import androidx.compose.ui.window.ComposeUIViewController
import com.cyxbs.components.config.compose.theme.AppTheme
import com.cyxbs.pages.login.ui.LoginPage

/**
 * .
 *
 * @author 985892345
 * @date 2025/2/22
 */

fun createLoginViewController() = ComposeUIViewController {
  AppTheme {
    LoginPage()
  }
}