# SleepWithAI
SleepWIthAI(A.K.A. SWAI) is application for users who want to sleep efficiently with personally optimized data. SWAI will recommend and turn on the alram at best time to wake up.

## Getting Started

You can see more detailed function at [SWAI Marketing Website](https://projectintheclass.github.io/SleepWithAI/)

### Installation

You can install on iOS devices (iOS 13+) at [Appstore](https://apps.apple.com/kr/app/). 

### How this Application Wake User

There are two main modes to wake up.

* **Normal Sleep Mode**

Normal Sleep Mode is for who needs to wake up at certain time. User can set time at Home tab with date picker. After clicking 'Sleep Now' button, SWAI will automatically record your sleeping sound and classify with CoreML machine learning model.

* **I Don't Care Mode (A.K.A. IDC)**

I Don't Care Mode is for who doesn't need to wake up at certain time. Very opposite from Normal Sleep Mode, user doesn't need to set time to wake up. SWAI will automatically get optimized sleep duration time and wake user up.

## Built With

* [Realm](http://www.realm.io/) - For User's Sleeping Data Process
* [Firebase](https://firebase.google.com/) - User Analytics
* [CoreML](https://developer.apple.com/documentation/coreml) - Classifying Sleeping Status

## Authors

* **Wanki Kim** - [Github](https://github.com/KimWanki)

* **Yeonji Lim** - [Github](https://github.com/Ymin-dgnn)

* **Yangjin Cho** - [Github](https://github.com/sheepjin99) / [Twitter](https://twitter.com/RieL_Dev) / [Facebook](https://www.facebook.com/profile.php?id=100014648160911) / [Blog](https://sheepjin99.tistory.com)



See also the list of [contributors](https://github.com/ProjectInTheClass/SleepWithAI/pulse) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* sleepyti.me - Quite different from our project, but initial idea was from this website.
* [Charts](https://github.com/danielgindi/Charts) - Used Cocoapod Framework for showing sleeping sound data to user.
