package com.example.siberian_coffee

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey("589a9f97-d241-44e4-a6fd-66dfb4591524")
  }
}
