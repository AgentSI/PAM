package com.example.lab1

import android.annotation.SuppressLint
import android.app.*
import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.widget.*
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.FileProvider
import java.io.File

private lateinit var photoFile: File
@Suppress("DEPRECATED_IDENTITY_EQUALS", "SameParameterValue", "DEPRECATION")
class MainActivity : AppCompatActivity() {
    @SuppressLint("QueryPermissionsNeeded", "ResourceType", "WrongViewCast")
    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.button_google).setOnClickListener {
            val intent = Intent(Intent.ACTION_WEB_SEARCH)
            val text = findViewById<EditText>(R.id.editText).text.toString()
            intent.putExtra(SearchManager.QUERY, text)
            startActivity(intent)
        }

        findViewById<Button>(R.id.button_notify).setOnClickListener {
            createNotificationChannel()

            val intent = Intent(this, MainActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            val pendingIntent: PendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE)
            val builder = NotificationCompat.Builder(this, "")
                .setSmallIcon(R.drawable.notification)
                .setContentText("hello")
                .setTimeoutAfter(10000)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setContentIntent(pendingIntent)

            with(NotificationManagerCompat.from(this)) {
                //val notificationId = Random.nextInt(1, 100)
                notify(1, builder.build())
            }
        }

        findViewById<Button>(R.id.button_camera).setOnClickListener {
            val takePictureIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            photoFile = getPhotoFile("photo.jpg")
            val fileProvider = FileProvider.getUriForFile(this, "com.example.lab1", photoFile)
            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, fileProvider)
            startActivityForResult(takePictureIntent, 0)
        }

        findViewById<Button>(R.id.button_call).setOnClickListener {
            val intent = Intent(Intent.ACTION_DIAL)
            val radioGroup = findViewById<RadioGroup>(R.id.radio_group)
            when (radioGroup!!.checkedRadioButtonId) {
                findViewById<Button>(R.id.radio_button_emergency).id -> {
                    intent.data = Uri.parse("tel:022 553 112")
                }
                findViewById<Button>(R.id.radio_button_taxi).id -> {
                    intent.data = Uri.parse("tel:14222")
                }
                else -> {
                    Toast.makeText(applicationContext,"Nothing selected", Toast.LENGTH_SHORT).show()
                }
            }
            startActivity(intent)
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "channel"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel("", name, importance)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                channel.setAllowBubbles(true)
            }
            with(NotificationManagerCompat.from(this)) {
                createNotificationChannel(channel)
            }
        }
    }

    private fun getPhotoFile(fileName: String): File {
        val storageDirectory = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        return File.createTempFile(fileName, ".jpg", storageDirectory)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 0 && resultCode == RESULT_OK) {
            val takenImage = BitmapFactory.decodeFile(photoFile.absolutePath)
            val imageView: ImageView = findViewById(R.id.imageView)
            imageView.setImageBitmap(takenImage)
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}