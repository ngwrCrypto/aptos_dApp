module wallet::calculator_l05ls
{
    use std::string::{String,utf8};
    use std::signer;

    struct Message has key
    {
        my_message : String
    }

    struct Calculator has key {
        result: u64,
    }

    public entry fun create_message(account: &signer)
    {
        if (!exists<Message>(signer::address_of(account))){
            let message = Message {
                my_message : utf8(b"Hi, it's my first dApp on the Aptos ecosystem")
            };
            move_to(account,message);
        }
    }

    public fun get_message(account: &signer): String acquires Message {
        let calculator = borrow_global<Message>(signer::address_of(account));
        calculator.my_message
    }

     // Passing the signer address to the function
    public entry fun create_calculator(account: &signer) acquires Calculator {
        // Defined the Calculator instance

         // We check if the signer address already has a Calculator resource
			  // associated to it
        if (exists<Calculator>(signer::address_of(account))){
            let calculator =
            borrow_global_mut<Calculator> (signer::address_of(account));
                calculator.result = 0;
        } else {
            let calculator = Calculator { result: 0};
            move_to(account, calculator);
        }
    }
}

