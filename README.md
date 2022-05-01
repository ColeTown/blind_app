# blind_app

Senior Capstone Project

Team Members:
-------------
Jett Graham, Cantrell Picou Jr., James Marks, Anderson McKennon, Cole Townsend

## Getting Started

This project was developed in the Android Studio Environment and thus will need Android Studio in order to
run the application on an emulated device. If Android Studio is not installed, search for it, download,
and install the latest version and open this project in it.

You will also have to download and install Flutter at https://docs.flutter.dev/get-started/install

You will have to create an emulated device with Android Studios 'Device Manager'. The Device Manager
wizard should help you with creating the emulator.

You will also have to change your run configuration before the application can be launched in this
environment. Go to Run>Edit Configurations>Additional run args and type "--no-sound-null-safety" in
the text box and save the changes. Now, you should be able to run the project through the emulator.

You will have to have install every module used in app.py by using the pip install command used for python.
To run the app.py app using flask, run the command "FLASK_APP=app.py flask run" in the terminal in the folder where
the app.py file is located. This should allow use of the program in the flutter app.