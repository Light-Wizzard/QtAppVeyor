# QtAppVeyor

كل برنامج يحتاج إلى سبب للوجود ،
هذا موجود لأنني كنت أعمل في مشروع لتحديث [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) من QML ،
إلى C ++ ، لذلك أريد أن أعمل على تطبيق Qt هذا على أكبر عدد ممكن من المنصات ،
بعد أن كان لديك برنامج Galaxy Calculator على [AppVeyor] (https://appveyor.com) لفترة من الوقت ،
قررت المحاولة،
ولكن سرعان ما وجدت صعوبة في تشغيل مشروعي على نظامي التشغيل Windows و Linux ،
هذا البرنامج أكثر تعقيدًا مع Library's ،
لذلك أردت كتابة تطبيق قصير فعل شيئًا مفيدًا في الوجود ،
ولكن في الوقت نفسه ، كان الهدف هو اختبار البرامج النصية الخاصة بي من AppVeyor ،
ثم قررت لماذا لا أقوم بإنشاء أداة AppVeyor Script Automation ،
والآن مفهومي هو استخدام برنامج Yaml Script الذي يضعه هذا التطبيق لنشر هذا التطبيق.

هذا المشروع مخصص لـ AppVeyor إذا كانوا يريدون تفرعها والاستيلاء عليها كمشروع مجتمعي ،
لجعله تطبيقًا أفضل ، ومنح المطورين شيئًا يعمل ،
حتى يتمكنوا من بناء مشاريعهم على هذا المشروع ،
واطلب منه التوافق مع أكبر عدد ممكن من الأنظمة الأساسية.

هذا تطبيق بسيط مكتوب بلغة Qt C ++ باستخدام Widgets ،
يستخدم SQL لتخزين المشاريع ،
إنه تطبيق بسيط يحتوي على صفحة إعدادات لإدخالها في جميع المتغيرات اللازمة لإنشاء ملف AppVeyor Yaml ،
لذلك بنقرة من الأسفل يمكنك أتمتة إنشاء ملف appveyor.yml.

هذا التطبيق هو في الأساس لتوضيح كيفية نشر مشاريع Qt C ++ QtCreator ،
على Linux و Mac و Windows وربما WebAssembly و iOS وكذلك Android ،
وكيفية استخدام Qt Installer Framework لإنشاء تطبيقات قابلة للتثبيت ،
يمكن تحديثها أيضًا.

هذا المشروع ليس موجهًا لمطوري برامج Qt فقط ،
يجب أن تكون قادرة على التعامل مع العديد من البيئات المختلفة ،
لكن Qt حاليًا هي البيئة الوحيدة التي أعمل عليها ،
لكنني أضفت زرًا لبيئات مختلفة ،
بهذه الطريقة ستكون هذه الأداة مفيدة لكل مطور برامج.

أكبر مشكلتي هي نقص خبرة البرمجة النصية لـ Windows ،
لم أستخدم Windows في Decades ، ولم أشتري إلا مؤخرًا Windows 10 Pro ،
لمجرد استخدام Word ، ولا أستخدم نظام Mac ، لذا فإن Linux هو كل ما يمكنني فعله حقًا ،
لذلك يمكنني حقًا استخدام بعض المساعدة في كتابة النصوص.

Qt تنتقل إلى cmake في الإصدار 6 ، لذلك ليس لدي خيار سوى الابتعاد عن qmake.

بالنسبة لنظام التشغيل Windows ، لست متأكدًا مما إذا كانت MingW هي الأداة الصحيحة ، أو إذا كانت VS كذلك ،
أو إذا كان يجب علي استخدام MSYS أو Cygwin.

## قائمة المحتويات

1. [مكسور] (https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [الحالة] (https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [التطور - التقدم] (https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [العمل على] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [المتغيرات] (https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [قاعدة البيانات] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [مساعدة] (https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [لقطات شاشة] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile] (https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [وثائق Doxygen] (https://light-wizzard.github.io/QtAppVeyor)

# مكسور

يجب العمل على الأشياء التي تم كسرها أولاً ،
هذه هي الأشياء التي أحتاج إلى المساعدة فيها.

1. لا تعمل إصدارات Windows x86 و x64 ، وأنا أستخدم windeploy ، وجميع ملفات dll موجودة ، لكنها لن تعمل.
2. إطار كيو تي المثبت.
3. Mac و WebAssembly و iOS و Android.
4. cmake ، مستقبل Qt 6.

المشكلات: يتوافق Windows ولكن لا يعمل بسبب ملفات dll الموجودة في نفس المجلد ، وهذا مشروع qmake ،
وقمت بإنشاء ملف cmake للعمل ، وأحتاج حقًا إلى التبديل إلى cmake للمشروع بأكمله ،
وهذا ما أعمل عليه حاليًا ، ولكن افتقاري إلى برمجة Windows أو PowerShell أو Command ،
أنا أفهم اللغة إلى حد ما ، بعد أن اضطررت إلى كتابة بعضها على مر السنين ،
هدفي هو وضع جميع البرامج النصية في ملفين ، أحدهما للتثبيت والآخر للإنشاء ،
أرغب في إنشاء حزمة Qt Installer Framework مع [Qt Auto Updates] (https://github.com/Skycoder42/QtAutoUpdater) ،
مشروع GitHub هذا موجه إلى Qt Installer Framework ،
على هذا النحو ، أريد فقط إنشاء ملف مضغوط واحد مع حزمة Qt Installer.

إذا كان بإمكاني تشغيل كل هذه الأشياء ، أود معرفة ما إذا كانت AppVeyor ستفرقها ،
ويمكننا العمل عليها هناك ، لقد كتبت لهم هذا لمنحهم للآخرين ،
لمساعدتهم في نشر تطبيقاتهم بسهولة ،
المفهوم بسيط ، يستخدم هذا التطبيق معظم الميزات التي يريدها معظم الناس ،
إعدادات Qt لتخزين المتغيرات ، و SQL ،
لذلك إذا كان بإمكانك جعل هذا يعمل مع جميع أنظمة التشغيل التي يدعمها Qt ،
سيسهل على الناس نسخ كيفية القيام بذلك ،
لذلك يحتاج هذا المشروع إلى الكثير من العمل لجعله أفضل مثال عملي ،
لذلك يمكنك أن ترى أنني أضفت فقط الحد الأدنى من الميزات التي يسهل توسيعها.

أحتاج إلى ملاحظات حول رأيك في هذا المفهوم ،
من التطبيق ، ما هي الميزات التي تريد أن تراها فيه ،
وأحتاج حقًا إلى معرفة النصوص البرمجية التي يجب تشغيلها لإنجاح كل ذلك ،
أنا جيد في bash ، لكن ليس كثيرًا في PowerShell أو CMD ،
وليس كثيرًا في Mac و iOS ، لكن لدي Android.

أريد أن أرى هذا التطبيق يصبح المعيار القياسي لـ AppVeyor للتوصية باستخدام ،
ولماذا يحتاجون إلى تفرعها وجعلها ملكًا لهم ،
أحاول فقط منحهم شيئًا يستحق توليه ،
ولماذا صنفت عليه QtAppVeyor ، وحاولت أن أجعل كل المستندات سهلة التنظيف ،
وجاهز Doxygen ، يجب إجراء الترجمة ،
لكنني أنتظر دائمًا حتى النهاية لبدء ذلك.

# حالة

[! [حالة إصدار Appveyor] (https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6؟svg=true)] (https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###: الحزمة: ** التنزيلات: **

 -: penguin: [Linux zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 -: المكتب: [Windows zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 -: apple: Currenty unavalible [Apple zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Currenty ، Windows لا يعمل ، إذا كان كذلك ، فسيقول شيئًا كالتالي:

Windows (تم اختباره في 7 و 10 ، أخبرني إذا كان 8 يعمل): قم بتنزيل zip واستخرجه ،
وقم بتشغيل الملف QtAppVeyor.exe داخل مجلد نشر AppDir.

عند اكتماله ، سيحتوي فقط على قطعة أثرية واحدة ، وهي Qt Installer Framework مع Qt Auto Update في ملف مضغوط.

# التقدم في عملية التنمية

لمزيد من المعلومات ، راجع: [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)

هذا عمل قيد التقدم ، يرجى الإبلاغ عن أي أخطاء وترك تعليقات.

# يعمل على

* cmake بدلا من qmake
* إطار كيو تي المثبت
* AppImage قابل للتحديث
* نصوص Windows بدلا من مضمنة
* ماك
* ذكري المظهر
* WebAssembly
* iOS
* بناء MSVS لمشروع كيو تي

# المتغيرات

إذا كنت تستخدم هذا التطبيق لإنشاء ملفات .appveyor.yml ،
ستحتاج إلى معرفة كل هذه المتغيرات ،
حتى لو أنشأت ملفًا خاصًا بك ، فستعرف هذه ،
والحفاظ على التغييرات يدويًا ،
حيث يتيح لك هذا التطبيق فقط تغيير المتغيرات وإنشاء ملف جديد.

يتم استخدام كل متغير في البرامج النصية لإعداد التطبيق للنشر.

* MY_BIN_PRO_RES_NAME: اسم مشروعات Qt ، أي. QtAppVeyor.pro ، يفترض أن اسم exe هو نفسه.
* MY_OS: يستخدم هذا لإنشاء أسماء الحزم ، لذلك لا توجد مسافات
* MY_VS_VERSION: إصدار كيو تي
* MY_QT_IF_VERSION: إصدار Qt Installer Framework (QIF)
* MY_QIF_PACKAGE_URI: مجلد لحزم QIF
* MY_PYTHON_VER: إصدار Python ، لاحظ أن Windows 7 يتوقف عند 3.8
* MY_PYTHON_REQUIRED: هل لغة Python مطلوبة
* MY_UPGRADE_OS: ترقية نظام Unix
* MY_QT_MINGW32: مسارات MingW
* MY_QT_MINGW32: مسارات MingW
* MY_QT_TOOLS_MINGW32: مسارات MingW
* MY_QT_TOOLS_MINGW64: مسارات MingW

يونكس

"يامل
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces ، يظهر هذا اسم الملف ، تنسيق شكل لوحة نظام التشغيل للمشروع
MY_QT_VERSION: 5.15.2 # Qt الإصدار
MY_QT_IF_VERSION: إصدار '4.1.1' # QT Installer Framework
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # آخر إصدار يمكن تشغيل Windows 7 هو 3.8.x
MY_PYTHON_REQUIRED: خطأ # إذا كانت لغة Python مطلوبة
MY_UPGRADE_OS: خطأ # apt-get Upgrade: صح أم خطأ فقط
MY_RUN_DOXYFILE: خطأ ، # تشغيل Doxygen
""

شبابيك

"يامل
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces ، يظهر هذا اسم الملف ، تنسيق شكل لوحة نظام التشغيل للمشروع
MY_QT_VERSION: 5.15.2 # Qt الإصدار
MY_VS_VERSION: إصدار 2019 # Vs
MY_QT_MINGW32: mingw81_32 # Windows فقط متغيرات مجلد Qt
MY_QT_MINGW64: mingw81_64 # Windows فقط متغيرات مجلد Qt
MY_QT_TOOLS_MINGW32: mingw810_32 # Windows فقط متغيرات مجلد Qt
MY_QT_TOOLS_MINGW64: mingw810_64 # Windows فقط متغيرات مجلد Qt
MY_QT_IF_VERSION: إصدار '4.1.1' # QT Installer Framework
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # آخر إصدار يمكن تشغيل Windows 7 هو 3.8.x
MY_PYTHON_REQUIRED: خطأ # إذا كانت لغة Python مطلوبة
MY_RUN_DOXYFILE: خطأ ، # تشغيل Doxygen
""

# قاعدة البيانات

'' sql
المشاريع: id، QtProject، Secret، IsOsUbuntu، IsOsMac، IsOsWebAssembly، IsOSiOS، IsOsWindows، IsOsAndroid، IsX64، IsX86، IsDebug، IsRelease

إنشاء مشاريع الجدول (معرف عدد صحيح PRIMARY KEY autoincrement ،
                      QtProject varchar ،
                      varchar السرية ،
                      IsOsUbuntu varchar ،
                      IsOsMac varchar ،
                      IsOsWebAssembly varchar ،
                      IsOSiOS varchar ،
                      IsOsWindows varchar ،
                      IsOsAndroid varchar ،
                      IsX64 varchar ،
                      IsX86 varchar ،
                      IsDebug varchar ،
                      IsRelease varchar

التكوين: معرف ، معرف المشروع ، نظام التشغيل ، QtVersion ، QtIfVersion ، QtIfPackageUri ، PythonVersion ، PythonRequired ، QtMingW32 ، QtMingW64 ، QtToolsMingW32 ، QtToolsMingW64 ، VisualStudio ، OsUpgrade

معرف المشروع هو معرف المشاريع

إنشاء تكوين الجدول (معرف عدد صحيح PRIMARY KEY autoincrement ،
                           معرفات varchar ،
                           نظام التشغيل varchar ،
                           QtVersion varchar ،
                           QtIfVersion varchar ،
                           QtIfPackage أوري varchar ،
                           PythonVersion varchar ،
                           Python: مطلوب varchar ،
                           QtMingW32 varchar ،
                           QtMingW64 varchar ،
                           QtToolsMingW32 varchar ،
                           QtToolsMingW64 varchar ،
                           VisualStudio varchar ،
                           OsUpgrade varchar

""

# يساعد

تم تضمين هذا التطبيق في [Help] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) في التطبيق نفسه ،
و [حول] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html) ،
بالإضافة إلى زر [المؤلف] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) في كلا مربعي الحوار ،
يمكنك إزالته بسهولة بمجرد إزالة الزر من النموذجين وإزالة الملف نفسه ،
هذا الزر والمحتوى يخصني المؤلف الأصلي ، لكن ليس مطلوبًا ،
ولا توجد أي تراخيص ، فهذا المشروع لديه ترخيص [غير مرخص] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) ،
هذا لتسهيل عمل أي شخص واستخدامه كنموذج ،
وسأحاول التوسع في أقسام المساعدة ،
وإضافة المزيد من محتوى [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki) ،
قد يساعد.

# لقطات الشاشة

! [الإعدادات] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

! [SQL] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

! [Ubuntu] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

! [Windows] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

! [الإعدادات الافتراضية] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

! [YML] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### نهاية- README.md