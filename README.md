# etiqaa_app

# Software:
to run the project:

1. Download requirements
- Android studio (2022.1.1.19-windows was used) 
(java version "11.0.17" 2022-10-18 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.17+10-LTS-269)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.17+10-LTS-269, mixed mode))
https://developer.android.com/studio

- xampp
https://www.apachefriends.org/

- python (Python 3.10.7 was used)
https://www.python.org/downloads/

- Flutter (version 3.3.10 was used), Dart (version 2.18.6 was used)
https://docs.flutter.dev/get-started/install

- php files download from https://github.com/maram46/etiqaa_php (must be replaced with one drive link)
and put in C:\xampp\htdocs folder

in Command Prompt run: 
- pip install camel-tools
- Pip install flask
- pip install Flask-Cors
- C:\Users\Your Name\AppData\Local\Programs\Python\Python310\Scripts>python -m pip install mysql-connector-python


2. Follow these steps:
Press the Windows button and type env.
Click on Edit the system environment variables (Control panel).
Click on the Environment Variables… button.
Click on the New… button under the User variables panel.
Type CAMELTOOLS_DATA in the Variable name input box and path the project from your device(for example: D:\desktop\etiqaa_app\python_files) in Variable value. Alternatively, you can browse for the data directory by clicking on the Browse Directory… button.
Click OK on all the opened windows.

3.If you are running the application on a physical mobile, first connect to the same computer network, then go to computer settings, then networks, then Wi-Fi, then the network characteristics that you are connected to, copy the ipv4 address and put it in:
- etiqaa_app\python_files\MLmodel.py  in the url variable
- etiqaa_app\etiqaa\lib\database\linkApi.dart file on line 1 in linkServerName variable
- etiqaa_app\etiqaa\lib\controllers\childUncomplete_controller.dart in the myServerUrl variable

4. run php server

5. create database with name 'etiqaa' then import etiqaa.sql in phpmyadmin, etiqaa.sql file: (https://drive.google.com/file/d/1959cYrwlRUd091MjJ5CDVsypr-xwh1ke/view?usp=sharing)

6. run python server by run Mlmodel.py file.

7. run without debugging for main.dart file


# Hardware:
The system will be compatible with Android devices that have the following attributes:
- The device type is a smartphone.
- The device runs on android version 6.0.1(Marshmallow) or above. 
- The device is connected to the internet.  
- The device has a Minimum of 4GB RAM and 32GB storage.
- The parent device must support Google Play services.
