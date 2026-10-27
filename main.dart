abstract class Connectable {
  void connectToWifi();
}

mixin Camera {
  void takePhoto() {
    print('Photo captured!');
  }
}

class Smartphone implements Connectable {
  String brand;
  String model;
  int batteryLevel;
  bool _isLocked;

  Smartphone(this.brand, this.model, this.batteryLevel, [this._isLocked = true]);

  bool get isLocked => _isLocked;

  void unlock(String pin) {
    if (pin == "1234") {
      _isLocked = false;
      print('$brand $model unlocked.');
    } else {
      print('Incorrect PIN.');
    }
  }

  void useApp(String appName) {
    if (_isLocked) {
      print('Cannot use $appName. Phone is locked.');
    } else {
      batteryLevel -= 10;
      print('Using $appName. Battery remaining: $batteryLevel%');
    }
  }

  
  Future<String> downloadSystemUpdate() async {
    print('Starting system update for $brand $model...');
    await Future.delayed(Duration(seconds: 2));
    batteryLevel -= 5;
    return '$brand $model system update completed successfully!';
  }

  @override
  void connectToWifi() {
    print('$brand $model connected to Wi-Fi.');
  }
}

class GamingPhone extends Smartphone {
  bool coolingFanOn;

  GamingPhone(String brand, String model, int batteryLevel, [this.coolingFanOn = false])
      : super(brand, model, batteryLevel);

  @override
  void useApp(String appName) {
    if (isLocked) {
      print('Cannot play $appName. Phone is locked.');
    } else {
      batteryLevel -= 20;
      print('Gaming mode active for $appName! Battery remaining: $batteryLevel%');
    }
  }
}

class CameraPhone extends Smartphone with Camera {
  int megapixels;

  CameraPhone(String brand, String model, int batteryLevel, this.megapixels)
      : super(brand, model, batteryLevel);

  @override
  void useApp(String appName) {
    if (isLocked) {
      print('Cannot use camera app $appName. Phone is locked.');
    } else {
      batteryLevel -= 5;
      print('Using camera app $appName at $megapixels MP. Battery remaining: $batteryLevel%');
    }
  }
}

// Week 11: main() function marked as async
void main() async {
  GamingPhone gamerPhone = GamingPhone('ASUS', 'ROG Phone 8', 90);
  CameraPhone camPhone = CameraPhone('Google', 'Pixel 8', 85, 50);

  List<Smartphone> inventory = [gamerPhone, camPhone];

  for (var phone in inventory) {
    phone.connectToWifi();
    phone.unlock('1234');
    phone.useApp('Game/App');

    if (phone is CameraPhone) {
      phone.takePhoto();
    }

    print('---');
  }

  
  print('\n=== ASYNC PROCESS DEMO ===');
  print('Initiating background update process...'); 

  
  String result = await gamerPhone.downloadSystemUpdate();
  print(result); 

  print('Final Battery Level: ${gamerPhone.batteryLevel}%');
}
