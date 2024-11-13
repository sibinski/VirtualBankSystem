// part1 
class VirtualBankSystem 
{
    var accountType = ""
    var isOpened = true
    func printWelcomeMessage()
    {
        let boldtext = "\u{001B}[1mWelcome to your virtual bank system.\u{001B}[0m"
        print(boldtext)
    }
    func printAccountOptions()
    {
    print("What kind of account would you like to make?")
    print("1. Debit account")
    print("2. Credit account")
    }
    func createAccount(numberPadKey: inout Int) 
    {
    print("The selected option is \(numberPadKey).")
    switch numberPadKey {
        case 1:
        accountType = "debit"
        break
        case 2:
        accountType = "credit"
        break
        default:
        print("Invalid input: \(numberPadKey). Please select 1 to create debit and 2 to create credit account.")
        }
        print("You've opened a \(accountType) account.")
    }
    func moneyTransfer(transferType:String, transferAmount:Int, bankAccount: inout BankAccount)
    {
    switch transferType {
        case "withdraw":
        if accountType == "credit"
        {
            bankAccount.creditWithdraw(transferAmount)
        }
        else if accountType == "debit"
        {
            bankAccount.debitWithdraw(transferAmount)
        }
        case "deposit":
        if accountType == "credit"
        {
            bankAccount.creditDeposit(transferAmount)
        }
        else if accountType == "debit"
        {
            bankAccount.debitDeposit(transferAmount)
        }
        default:
        break
    }
    }
    func checkBalance(bankAccount:BankAccount)
    {
        switch accountType {
            case "credit":
            
                print("\(bankAccount.creditBalanceInfo)")
            
            case "debit":
            
                print("\(bankAccount.debitBalanceInfo)")
            
            default:
            break 
        }
    }

}
//part 2
struct BankAccount {
    var debitBalance = 0
    var creditBalance = 0
    let creditLimit = 100

    var debitBalanceInfo: String {
        return "Debit balance: $\(debitBalance)."
    }
    
    var availableCredit: Int {
        return creditLimit + creditBalance
    }
    
    var creditBalanceInfo: String {
        return "\n\u{001B}[1mAvailable credit: $\u{001B}[0m\(availableCredit)."
    }

    mutating func debitDeposit(_ amount: Int) {
    debitBalance += amount
    print("Deposited $\(amount). \(debitBalanceInfo)")
    }
    
    mutating func creditDeposit(_ amount: Int) {
        creditBalance += amount
        print("Credit $\(amount). \(debitBalanceInfo)")
        
        if creditBalance == 0 {
            print("Paid off credit balance.")
        } 
        else if creditBalance > 0 {
            print("Overpaid credit balance.")
        }
    }

    mutating func debitWithdraw(_ amount: Int) {
        if amount > debitBalance {
            print("Insufficient funds to withdraw $\(amount). \(debitBalanceInfo)")
        } else {
            debitBalance -= amount
            print("Debit withdraw: $\(amount). \(debitBalanceInfo)")
        }
    }

    mutating func creditWithdraw(_ amount: Int) {
        if amount > availableCredit {
            print("Insufficient credit to withdraw $\(amount). \(creditBalanceInfo)")
        } else {
            creditBalance -= amount
            print("Credit withdraw: $\(amount). \(creditBalanceInfo)")
        }
    }
}
// Usage
let virtualBankSystem = VirtualBankSystem()
virtualBankSystem.printWelcomeMessage()
repeat {
    virtualBankSystem.printAccountOptions()
    var numberPadKey = Int.random(in: 1...3) // Example of input, can be changed to test
    virtualBankSystem.createAccount(numberPadKey: &numberPadKey)  // Passing by reference to allow modification
} while virtualBankSystem.accountType == ""
var bankAccount = BankAccount(debitBalance: 50, creditBalance: 20)  // Initialize with default values
repeat {
    print("\nWhat would you like to do?\n1. Check bank account\n2. Withdraw money\n3. Deposit money\n4. Close the system")
    let option: Int = Int.random(in: 1...5)
    print("Your choice was:\(option)")
    switch option
    {
        case 1:
        
            virtualBankSystem.checkBalance(bankAccount:bankAccount)
        
        case 2:
            let transferAmount = 10
            virtualBankSystem.moneyTransfer(transferType:"withdraw",transferAmount:transferAmount,bankAccount:&bankAccount)
        
        case 3:
            let transferAmount = 10
            virtualBankSystem.moneyTransfer(transferType:"deposit",transferAmount:transferAmount,bankAccount:&bankAccount)
        
        case 4:
        
            virtualBankSystem.isOpened = false
            print("The system is closed.")
        
        default:
        break
    }
} while virtualBankSystem.isOpened

print(bankAccount.debitBalanceInfo)
bankAccount.debitDeposit(_: 100)
bankAccount.creditDeposit(_:20)
bankAccount.debitWithdraw(10)
bankAccount.creditWithdraw(40)