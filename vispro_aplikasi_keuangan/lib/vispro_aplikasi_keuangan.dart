import 'dart:io';
import 'dart:core';

class ExpenseEntry {
  int amount;
  int category;
  DateTime date;
  String? note;

  ExpenseEntry(this.amount, this.category, this.date, {this.note});
}

class ExpenseTracker {
  List<ExpenseEntry> expenseHistory = [];

  void addExpense(int amount, int category, DateTime date, {String? note}) {
    final expense = ExpenseEntry(amount, category, date, note: note);
    expenseHistory.add(expense);
  }
  // Menampilkan History Pengeluaran
  void displayExpenseHistory() {
    print('Riyawat Pengeluaran');
    for (var entry in expenseHistory) {
      print("Jumlah   : ${entry.amount}");
      print("Category : ${entry.category}");
      if (entry.note != null) {
        print("Catatan : ${entry.note}");
      }
      print("Tanggal  : ${entry.date}");
      print("\n");
    }
  }
  // Menampilkan Total Pengeluaran
  void displayTotalExpense() {
    int totalExpense = 0;
    for (var entry in expenseHistory) {
      totalExpense += entry.amount;
    }
    print('Total Expense $totalExpense');
  }
}

void main() {
  var myExpense = ExpenseTracker();

  void calcExpense() {
    stdout.write('Amount: ');
    String? amountStr = stdin.readLineSync();
    if (amountStr != null) {
      int amount = int.tryParse(amountStr) ?? 0;

      stdout.write('Category: ');
      String? categoryStr = stdin.readLineSync();
      int category = int.tryParse(categoryStr ?? '0') ?? 0;

      stdout.write('Date: ');
      String? dateStr = stdin.readLineSync();
      DateTime date = DateTime.tryParse(dateStr ?? '') ?? DateTime.now();

      stdout.write('Note: ');
      String? note = stdin.readLineSync();

      myExpense.addExpense(amount, category, date, note: note);
    }
  }

  void runMyExpense() {
    print('\nAplikasi Keuangan Pribadi myExpense');
    stdout.write('Masukkan Pilihan Anda: \n');
    print('1. Masukan Pengeluaran Anda:');
    print('2. Tampilkan History Pengeluaran:');
    print('3. Tampilkan Total Pengeluaran:');

    String? yourchoiceStr = stdin.readLineSync();
    int yourchoice = int.tryParse(yourchoiceStr ?? '0') ?? 0;
    if (yourchoice == 1) {
      calcExpense();
      runMyExpense();
    } else if (yourchoice == 2) {
      myExpense.displayExpenseHistory();
      runMyExpense();
    } else if (yourchoice == 3) {
      myExpense.displayTotalExpense();
      runMyExpense();
    } else if (yourchoice != 1 || yourchoice != 2 || yourchoice != 3) {
      print('Please Input Right Number: ');
      runMyExpense();
    } else {
      exit(0);
    }
  }

  runMyExpense();
}
