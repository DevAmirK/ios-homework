// TASK 1
// OUTPUT MULTIPLICATION TABLE  1-10
void task1(int digit) {
  print('MULTIPLICATION TABLE for $digit:');
  for (int i = 1; i <= 10; i++) {
    print('$digit * $i = ${digit * i}');
  }
}

// TASK 2
// next day : examples:
// 05.09.2026 -> 06.09.2026
// 28.02.2024 -> 29.02.2024
// 28.02.2026 -> 01.03.2026
// 29.02.2026 -> invalid date
// 28.02.2100 -> 01.03.2100
// 28.02.2100 -> 29.02.2000
// 31.12.2025 -> 01.01.2026
// 2000,2400 leap year
// 2100,2200,2300 isn`t leap year
void task2(String date) {
  List<String> parts = date.split('.');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  List<int> daysInMonths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    daysInMonths[2] = 29;
  }

  if (month < 1 || month > 12 || day < 1 || day > daysInMonths[month]) {
    print('$date - invalid date');
    return;
  }

  day++;

  if (day > daysInMonths[month]) {
    day = 1;
    month++;
    if (month > 12) {
      month = 1;
      year++;
    }
  }

  String strDay = day < 10 ? '0$day' : '$day';
  String strMonth = month < 10 ? '0$month' : '$month';
  
  print('$date -> $strDay.$strMonth.$year');
}

// TASK3
// Vowel Counter in a String -> "flutter mobile development" -> 8
void task3(String str) {
  int count = 0;
  for (int i = 0; i < str.length; i++) {
    if (str[i] == 'a' || str[i] == 'e' || str[i] == 'i' || str[i] == 'o' || str[i] == 'u') {
      count++;
    }
  }
  print(str);
  print('Vowels: $count');
}

// TASK4
// Manual min & max finder
void task4(List<int> numbers) {
  int min = numbers[0];
  int max = numbers[0];

  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }
    if (numbers[i] > max) {
      max = numbers[i];
    }
  }
  print('min: $min, max: $max');
}

// TASK 5
// Prime Number Checker
// 3 -> prime number
// 6 -> not prime number
void task5(int number) {
  if (number <= 1) {
    print('$number - not prime number');
    return;
  }

  bool isPrime = true;
  for (int i = 2; i < number; i++) {
    if (number % i == 0) {
      isPrime = false;
      break;
    }
  }

  if (isPrime) {
    print('$number - prime number');
  } else {
    print('$number - not prime number');
  }
}

//

void processOrder({
  required int orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee
}) {
  double price = itemPrice;
  if (promoCode == 'SAVE10') price *= 0.9;

  double fee = deliveryFee ?? 500.0;
  if (fee < 500.0) fee = 500.0;
  double total = price + fee;

  print('Summary for #$orderId: Price: $itemPrice, Promo: $promoCode, Fee: $fee, Total: $total');
}

//

void checkBalance({
  required String name,
  required double balance,
}) {
  print('$name Доступный баланс: $balance');
}

double deposit({
  required double currentBalance,
  double? amount,
}) {
  double depositAmount = amount ?? 0.0;
  double newBalance = currentBalance + depositAmount;
  print('Пополнение: $depositAmount. Новый баланс: $newBalance');
  return newBalance;
}

double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int inputPin = pinCode ?? 0000;
  if (inputPin != 1234) {
    print('Ошибка: Неверный пин-код. Транзакция отклонена.');
    return currentBalance;
  }

  double withdrawAmount = amount ?? 0.0;
  if (withdrawAmount > currentBalance) {
    print('Ошибка: Недостаточно средств. Транзакция отклонена.');
    return currentBalance;
  }

  double newBalance = currentBalance - withdrawAmount;
  print('Снятие: $withdrawAmount. Остаток: $newBalance');
  return newBalance;
}

void main () {
  // Task 1-5
  print('Task 1');
  task1(6);
  print('');

  print('Task 2');
  task2('31.12.2025');
  task2('29.02.2026');
  print('');

  print('Task 3');
  task3('flutter mobile development');
  task3('test text');
  print('');

  List<int> numbers = [14, 88, 3, 42, 99, 12, 67]; //-> max: 99, min: 3
  List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67]; //-> max: 949, min: 34

  print('Task 4');
  task4(numbers);
  task4(numbers1);
  print('');

  print('Task 5');
  task5(3);
  task5(6);
  print('');


  // Homework 1
  // processOrder(orderId: 1, itemPrice: 1000.0);
  // processOrder(orderId: 2, itemPrice: 2000.0, promoCode: 'SAVE10');
  // processOrder(orderId: 3, itemPrice: 3000.0, deliveryFee: 0.0);
  // processOrder(orderId: 4, itemPrice: 3000.0, deliveryFee: 700.0);


  // Homework 2
  // double balance = 100.0;
  // String user = 'Amir';
  //
  // checkBalance(name: user, balance: balance);
  //
  // balance = deposit(currentBalance: balance, amount: 50.0);
  // balance = deposit(currentBalance: balance, amount: null);
  //
  // balance = withdraw(name: user, currentBalance: balance, amount: 30.0, pinCode: 1234);
  // balance = withdraw(name: user, currentBalance: balance, amount: 200.0, pinCode: 1234);
  // balance = withdraw(name: user, currentBalance: balance, amount: 20.0, pinCode: 0000);
}
