import com.mredrock.cyxbs.convention.depend.dependCoroutines
import com.mredrock.cyxbs.convention.depend.lib.dependLibUtils

plugins {
  id("module-manager")
}

dependLibUtils()

dependCoroutines()