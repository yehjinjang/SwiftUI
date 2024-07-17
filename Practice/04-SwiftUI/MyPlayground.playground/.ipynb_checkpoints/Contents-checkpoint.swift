//class 생성

//class className : parent class {
//    //property
//    // let ,var definition
//    //instance method
//    // type method
//}


class BankAccount {
    //property
    var accountBlank : Float = 0
    var accountNumber : Int = 0
    let fees  : Float = 25.00
    
    
    var balanceLessFees: Float {
        get{
            return accountBalance - fees
        }
    }
    
    init() {
        accountBalance = 0
        accountNumber = 0
    }

    init (number: Int, balance: Float){
        accountNumber = number
        accountBalance = balance
    }

    //instance method
    func displayBalance(){
        print("Number \(accountNumber)")
        print("Current balance is \(accountBlank)")
    }
    //type method (class type method 상속 재정의 가능, static 은 재정의 불가능 )
    static func getMaxBalance() -> Float {
        return 100000.00
        
    }
}

var bankAccount = BankAccount()

print(bankAccount.accountBlank)
print(bankAccount.accountNumber)

bankAccount.displayBalance()


