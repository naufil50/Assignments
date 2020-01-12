class User
    STATUS = [
      'active',
      'inactive',
      'pending'
    ]
  
    def initialize(status:)
      check_valid_status(status)
      @status = status
    end
  
    def status=(status)
      check_valid_status(status)
      @status = status
    end
  
    STATUS.each do |status_val|
      define_method :"#{status_val}?" do
        status_val == @status
      end
    end
  
    private
  
    def check_valid_status(status)
      raise " #{status} is invalid status. Valid status are #{STATUS}" unless STATUS.include?(status)
    end
  end
  
  user = User.new(status: 'active')
  puts user.active?
  puts user.pending?

  user.status = 'pending'
  puts user.active?
  puts user.pending?


#   Below status is not valid
  user.status = 'wrong status'
