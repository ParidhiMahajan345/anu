🌍 AnubhavX — World Tourism & VR Experiences
Experience the World Beyond Reality
AnubhavX is a tourism-focused mobile application that combines Virtual Reality (VR) with a Flutter-based application to provide immersive digital experiences of heritage sites, monuments, museums, and tourist destinations.

The project aims to make tourism experiences more accessible, interactive, and inclusive, particularly for people who may face physical, geographical, financial, or mobility-related limitations.

📌 About the Project
Tourism is not equally accessible to everyone. Elderly people, persons with disabilities, people with mobility limitations, and individuals who cannot travel due to distance or financial constraints may not be able to experience important tourist and heritage destinations physically.

AnubhavX addresses this gap by providing virtual experiences that allow users to explore destinations digitally.

The application combines:

📱 Flutter for the mobile application
🥽 Unity + VR for immersive experiences
💳 Razorpay for payment integration
❤️ ESP32 pulse sensor for interactive VR experiences
🌍 Digital tourism and heritage content
🎯 Objectives
The main objectives of AnubhavX are:

To provide immersive virtual tourism experiences.
To improve accessibility to heritage and tourist destinations.
To allow users to explore places without physically travelling.
To provide an interactive experience rather than only photographs or videos.
To create a platform that can support elderly users and persons with disabilities.
To combine mobile technology with VR for tourism and education.
✨ Key Features
🌍 Virtual Tourism
Users can explore selected tourist destinations and heritage locations through immersive digital experiences.

🥽 VR Experience
The project uses Unity to create interactive VR environments that can be experienced using compatible VR hardware.

📱 Flutter Mobile Application
Flutter is used to develop the main mobile application and provide the user interface for accessing the tourism experiences.

❤️ Pulse Sensor Interaction
An ESP32-based pulse sensor can be connected to the VR experience.

The sensor can detect the user's pulse rate and can be used to create interactive responses within the experience.

🔔 Interactive Elements
The VR environment includes interactive elements such as:

Bell interaction
Flower interaction
Movement in different directions
Interactive heritage/religious environment
💳 Payment Integration
The application includes Razorpay integration for handling the payment flow for experiences.

🏗️ System Architecture
The project consists of three major components:

                 ┌──────────────────────┐
                 │      ANUBHAVX         │
                 │   Flutter Mobile App  │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │   User Experience    │
                 │ Destination Selection│
                 │   & App Navigation   │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │     Unity VR         │
                 │ Immersive Experience │
                 └──────────┬───────────┘
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
    ┌─────────────────┐          ┌─────────────────┐
    │   VR Controls   │          │  ESP32 Sensor   │
    │ Movement/Inter- │          │ Pulse Monitoring│
    │     actions     │          └─────────────────┘
    └─────────────────┘
🛠️ Technology Stack
Technology	Purpose
Flutter	Mobile application development
Dart	Flutter programming language
Unity	VR environment and interaction
C#	Unity scripting
ESP32	Hardware-based pulse sensing
Razorpay	Payment integration
Meta Quest	Target VR hardware
Git & GitHub	Version control and project management
🎮 VR Experience
The VR component of AnubhavX is developed using:

Unity Version: 2022.3.62f3

The VR environment uses an OVR Rig for VR interaction.

The project is designed around an immersive tourism experience where users can:

Move forward
Move backward
Move left
Move right
Interact with objects
Ring a virtual bell
Interact with flowers
Explore the virtual environment
❤️ ESP32 Pulse Sensor
An ESP32-based pulse sensor is used as an additional interaction mechanism.

The sensor communicates through:

COM6
with a baud rate of:

115200
The pulse information can be used to create interactive responses inside the VR environment.

For example:

Pulse Sensor
      ↓
    ESP32
      ↓
Serial Communication
      ↓
Unity VR
      ↓
Interactive Experience
📱 Flutter Application
The Flutter application acts as the main interface for AnubhavX.

The application can be used to:

Navigate through the platform
Explore tourism experiences
Access VR experiences
View relevant destination information
Handle payment-related functionality
The Flutter project package is:

anubhavx
💳 Payment Integration
AnubhavX includes Razorpay integration to support the payment flow for tourism experiences.

The general flow is:

User
 ↓
Select Experience
 ↓
Payment
 ↓
Razorpay
 ↓
Access Experience
🥽 Target Hardware
The project is designed with VR headsets such as Meta Quest in mind.

The planned hardware setup includes:

Meta Quest VR headset
ESP32
Pulse sensor
Compatible computer for development/testing
📂 Project Structure
A simplified structure of the project is:

AnubhavX/
│
├── Flutter_App/
│   ├── lib/
│   ├── assets/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
│
├── Unity_VR/
│   ├── Assets/
│   ├── Packages/
│   ├── ProjectSettings/
│   └── ...
│
├── ESP32/
│   └── pulse_sensor_code/
│
└── README.md
The exact folder structure may vary depending on the latest project version.

🚀 Getting Started
Prerequisites
Before running the project, install:

Flutter SDK
Dart SDK
Android Studio
Unity 2022.3.62f3
Visual Studio / required Unity development tools
Git
Compatible VR hardware for VR testing
ESP32 development environment for hardware interaction
🔧 Run the Flutter Application
Clone the repository:

git clone https://github.com/ParidhiMahajan345/anu.git
Navigate to the project:

cd anu
Install Flutter dependencies:

flutter pub get
Run the application:

flutter run
🎮 Run the Unity VR Project
Install Unity 2022.3.62f3.
Open Unity Hub.
Add/open the Unity VR project.
Open the project in Unity.
Connect the supported VR device.
Build and run the VR experience.
🔌 ESP32 Setup
Connect the pulse sensor to the ESP32.
Upload the ESP32 code.
Connect the ESP32 to the computer.
Select the appropriate COM port.
Use the configured baud rate:
115200
Start the Unity application and establish serial communication.
🌟 Current Implementation
The current prototype includes:

✅ Flutter mobile application
✅ Unity VR environment
✅ VR movement
✅ Forward/backward movement
✅ Left/right movement
✅ Bell interaction
✅ Flower interaction
✅ ESP32 pulse sensor integration
✅ Razorpay payment integration
✅ Tourism-focused VR experience
🔮 Future Scope
AnubhavX can be expanded with:

🌍 More tourist destinations
🏛️ Virtual museums and heritage sites
🥽 Support for additional VR devices
🎙️ Voice guidance
🌐 Multiplayer virtual tourism
🗺️ Interactive tourism maps
🌏 Multiple languages
♿ Improved accessibility features
👨‍🏫 Educational tourism experiences
📊 User experience analytics
🎟️ Virtual tourism packages
🏨 Integration with tourism services
🎯 Target Users
AnubhavX is designed to support a wide range of users, including:

👴 Elderly people
♿ Persons with disabilities
🧑‍🦽 People with mobility limitations
🎓 Students
🌍 Tourists
🏛️ Heritage enthusiasts
📚 Educational institutions
💡 Why AnubhavX?
Traditional tourism requires a person to physically travel to a destination.

AnubhavX introduces another possibility:

Traditional Tourism
       ↓
Physical Travel
       ↓
Destination
       ↓
Experience


AnubhavX
       ↓
Mobile Application
       ↓
Virtual Reality
       ↓
Immersive Experience
The goal is not to replace real tourism, but to provide an alternative way to experience destinations when physical travel is difficult or inaccessible.

🏆 Project Achievements
AnubhavX has been developed as a student innovation project and has participated in innovation and entrepreneurship-oriented events.

The project has been presented at:

Innovathon 1.0 — University of Jammu
Smart Solutions Exhibition 2.0 — Shri Mata Vaishno Devi University
ASCEND J&K
👩‍💻 Team
Team AnubhavX
Diya Rani
Paridhi Mahajan
Vidhita Arora
University: University of Jammu

📜 Project Status
Status: 🚧 Prototype / Under Development

AnubhavX is currently being developed as a working prototype combining a Flutter mobile application, Unity-based VR experience, and hardware interaction.

🤝 Contribution
Contributions and suggestions are welcome.

If you would like to contribute:

git clone https://github.com/ParidhiMahajan345/anu.git
Create a new branch:

git checkout -b feature-name
Make your changes and submit a pull request.

📄 License
This project is currently developed as an academic/student innovation project.

For permissions regarding reuse, modification, or commercial deployment, please contact the project team.

🌍 AnubhavX
Experience the World Beyond Reality
Redefining accessibility through VR.
