plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.moduleCourse.apiCourse)
  implementation(projects.cyxbsPages.affair.api)
}