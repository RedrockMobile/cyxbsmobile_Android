import androidx.compose.material.Typography
import androidx.compose.runtime.Composable
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp
import cyxbsmobile.cyxbs_applications.test.generated.resources.Res
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Bold
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_ExtraLight
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Heavy
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Light
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Medium
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Normal
import cyxbsmobile.cyxbs_applications.test.generated.resources.SourceHanSansCN_Regular
import org.jetbrains.compose.resources.Font

/**
 * wasmJs 端的 skiko 不支持中文字体，只能把字体文件打进去
 *
 * @author 985892345
 * @date 2024/12/29
 */

@Composable
fun createTypography() : Typography = Typography(
  defaultFontFamily = getFontFamily(),
  body1 = TextStyle.Default.copy(
    fontWeight = FontWeight.Normal,
    fontSize = 16.sp,
    letterSpacing = 0.5.sp
  )
)

// 思源黑体 https://github.com/adobe-fonts/source-han-sans/tree/release
// 压缩教程 https://moyuscript.github.io/MoyuScript/2022/10/26/font-compress/
@Composable
fun getFontFamily(): FontFamily = FontFamily(
  Font(
    Res.font.SourceHanSansCN_ExtraLight,
    FontWeight.ExtraLight,
  ),
  Font(
    Res.font.SourceHanSansCN_Light,
    FontWeight.Light,
  ),
  Font(
    Res.font.SourceHanSansCN_Normal,
    FontWeight.Normal,
  ),
  Font(
    Res.font.SourceHanSansCN_Regular,
    FontWeight.Medium,
  ),
  Font(
    Res.font.SourceHanSansCN_Medium,
    FontWeight.SemiBold,
  ),
  Font(
    Res.font.SourceHanSansCN_Bold,
    FontWeight.Bold,
  ),
  Font(
    Res.font.SourceHanSansCN_Heavy,
    FontWeight.ExtraBold,
  ),
)