package com.example.izobility_mobile

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }
}
