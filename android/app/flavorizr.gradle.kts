import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.group_exito.dev"
            resValue(type = "string", name = "app_name", value = "Group Exito Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.group_exito"
            resValue(type = "string", name = "app_name", value = "Group Exito")
        }
    }
}