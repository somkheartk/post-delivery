# Quick Start Guide - Post Delivery App

## 🚀 เริ่มต้นใช้งาน

### ข้อกำหนดเบื้องต้น
- Flutter SDK 3.0.0 หรือสูงกว่า
- Dart 3.0.0 หรือสูงกว่า
- Android Studio / VS Code
- Android SDK / iOS SDK (สำหรับรันบนอุปกรณ์จริง)

### การติดตั้ง

1. **Clone Repository**
```bash
git clone https://github.com/somkheartk/post-delivery.git
cd post-delivery
```

2. **ติดตั้ง Dependencies**
```bash
flutter pub get
```

3. **ตรวจสอบ Flutter**
```bash
flutter doctor
```

4. **รัน Application**

สำหรับ Android:
```bash
flutter run
```

สำหรับ iOS:
```bash
flutter run -d ios
```

สำหรับ Web:
```bash
flutter run -d chrome
```

### การทดสอบ

**รัน Tests**
```bash
flutter test
```

**ดู Coverage**
```bash
flutter test --coverage
```

### โครงสร้างโปรเจกต์

```
post_delivery/
│
├── lib/                          # โค้ดหลัก
│   ├── main.dart                # จุดเริ่มต้นแอป
│   └── screens/                 # หน้าจอต่างๆ
│       ├── home_screen.dart     # หน้าหลัก
│       ├── booking_screen.dart  # จองพัสดุ
│       ├── tracking_screen.dart # ติดตามพัสดุ
│       └── receiving_screen.dart# รับพัสดุ
│
├── test/                        # ไฟล์ทดสอบ
│   └── widget_test.dart
│
├── assets/                      # รูปภาพและไอคอน
│   ├── images/
│   └── icons/
│
├── pubspec.yaml                 # Dependencies
├── README.md                    # คู่มือโปรเจกต์
├── APP_FEATURES.md             # รายละเอียดฟีเจอร์
└── UI_GUIDE.md                 # คู่มือการออกแบบ UI
```

## 📱 การใช้งานแอป

### 1. หน้าหลัก (Home)
- เปิดแอป → เห็นหน้าหลักพร้อมบริการต่างๆ
- เลือกบริการที่ต้องการ:
  - **จองส่งพัสดุ** - สร้างการจองใหม่
  - **ติดตามพัสดุ** - ตรวจสอบสถานะ
  - **รับพัสดุ** - จัดการพัสดุที่รอรับ

### 2. การจองพัสดุ
1. คลิก "จองส่งพัสดุ" จากหน้าหลัก
2. กรอกข้อมูลผู้ส่ง (ชื่อ, โทร, ที่อยู่)
3. กรอกข้อมูลผู้รับ (ชื่อ, โทร, ที่อยู่)
4. ใส่รายละเอียดพัสดุ
5. เลือกขนาด (S/M/L/XL)
6. ปรับน้ำหนัก (ด้วย slider)
7. ดูค่าส่งที่คำนวณอัตโนมัติ
8. กดยืนยันการจอง
9. รับหมายเลขติดตาม

### 3. การติดตามพัสดุ
1. ไปที่แท็บ "ติดตามพัสดุ"
2. ใส่หมายเลขติดตาม (หรือสแกน QR)
3. กดค้นหา
4. ดูสถานะและ timeline การจัดส่ง

### 4. การรับพัสดุ
1. ไปที่แท็บ "รับพัสดุ"
2. ดูรายการพัสดุทั้งหมด
3. กรองตามสถานะ (ถ้าต้องการ)
4. คลิกพัสดุที่ต้องการดูรายละเอียด
5. กด "รับพัสดุ" เพื่อยืนยัน

## 🎨 ธีมและสี

แอปใช้สีหลักแบบ Flash Express:
- **สีหลัก**: ส้ม #FF6B00
- **สีรอง**: เหลือง #FFB800
- **พื้นหลัง**: ขาว #FFFFFF

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  intl: ^0.18.0           # จัดรูปแบบวันที่เวลา
  google_fonts: ^6.1.0    # ฟอนต์สวยๆ
  flutter_svg: ^2.0.9     # รองรับ SVG (อนาคต)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0   # ตรวจสอบโค้ด
```

## 🔧 Troubleshooting

### ปัญหา: Flutter command not found
```bash
# ตั้งค่า PATH
export PATH="$PATH:[path-to-flutter]/flutter/bin"
```

### ปัญหา: Dependencies ไม่โหลด
```bash
flutter clean
flutter pub get
```

### ปัญหา: Build failed
```bash
flutter clean
flutter pub get
flutter run
```

## 📚 เอกสารเพิ่มเติม

- **README.md** - ภาพรวมโปรเจกต์
- **APP_FEATURES.md** - รายละเอียดฟีเจอร์ทั้งหมด
- **UI_GUIDE.md** - คู่มือการออกแบบ UI

## 💡 เคล็ดลับ

1. **Hot Reload** - กด `r` ระหว่าง flutter run เพื่อ reload
2. **Hot Restart** - กด `R` เพื่อ restart แอป
3. **Quit** - กด `q` เพื่อออกจากแอป
4. **Debug Mode** - ใช้ Flutter DevTools สำหรับ debug

## 🎯 สิ่งที่ต้องพัฒนาต่อ (Optional)

- [ ] เชื่อมต่อกับ Backend API จริง
- [ ] เพิ่มระบบ Authentication
- [ ] รองรับ QR Code Scanning จริง
- [ ] เพิ่ม Payment Gateway
- [ ] รองรับหลายภาษา (EN/TH)
- [ ] เพิ่ม Push Notification
- [ ] Map Integration สำหรับติดตาม
- [ ] History และ Analytics

## 🤝 การมีส่วนร่วม

หากต้องการพัฒนาเพิ่มเติม:
1. Fork repository
2. สร้าง feature branch
3. Commit การเปลี่ยนแปลง
4. Push ไปยัง branch
5. เปิด Pull Request

## 📞 ติดต่อ

หากมีคำถามหรือข้อเสนอแนะ สามารถเปิด Issue ใน GitHub

---

**Happy Coding! 🚀**
