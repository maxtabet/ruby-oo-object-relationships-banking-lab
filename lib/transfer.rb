class Transfer
    attr_accessor :sender, :receiver, :status, :amount, :balance

    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end

    def valid?
      if self.sender.valid? && self.receiver.valid?
        true 
      end
    end

    def execute_transaction
      if self.receiver.valid? && self.status == "pending" && self.sender.balance > self.amount
        self.sender.deposit(-amount)
        self.receiver.deposit(amount)
        self.status = "complete"
      else
        self.status = "rejected"
        return "Transaction rejected. Please check your account balance."
      end
    end

    def reverse_transfer
      if self.status == "complete"
        self.sender.deposit(amount)
        self.receiver.deposit(-amount)
        self.status = "reversed"
      end
    end



end
