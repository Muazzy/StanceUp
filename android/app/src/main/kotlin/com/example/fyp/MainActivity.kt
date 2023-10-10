// package com.example.fyp

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
// }


package com.example.fyp

import android.content.res.AssetFileDescriptor
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.Interpreter
import java.io.FileInputStream
import java.nio.MappedByteBuffer
import java.nio.channels.FileChannel
import java.util.ArrayList

class MainActivity : FlutterActivity() {
    private val CHANNEL = "ondeviceML"
    private lateinit var tflite: Interpreter

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "predictData") {
                try {
                    tflite = Interpreter(loadModelFile(call.argument<String>("model") + ".tflite"))
                } catch (e: Exception) {
                    Log.e("MainActivity", "Exception while loading: $e")
                    throw RuntimeException(e)
                }
                val args = call.argument<ArrayList<Double>>("arg")
                val prediction = predictData(args)
                if (prediction != 0f) {
                    result.success(prediction)
                } else {
                    result.error("UNAVAILABLE", "prediction not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun predictData(inputData: ArrayList<Double>?): Float {
        val inputArray = Array(1) { FloatArray(inputData?.size ?: 0) }
        inputData?.forEachIndexed { index, e ->
            inputArray[0][index] = e.toFloat()
        }
        val outputData = Array(1) { FloatArray(1) }
        tflite.run(inputArray, outputData)

        Log.d("tag", ">> " + outputData[0][0])

        return outputData[0][0]
    }

    private fun loadModelFile(modelName: String): MappedByteBuffer {
        val fileDescriptor = assets.openFd(modelName)
        val inputStream = FileInputStream(fileDescriptor.fileDescriptor)
        val fileChannel = inputStream.channel
        val startOffset = fileDescriptor.startOffset
        val declaredLength = fileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }
}
