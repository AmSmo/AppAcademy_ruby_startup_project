require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries.has_key?(title)

    end

    def >(startup)
        if self.funding > startup.funding
            return true
        else
            return false
        end  
    end


    def hire(name, title)
        if valid_title?(title)
            name = Employee.new(name, title)
            @employees << name
        else
            raise "error"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        if @funding >= salary
            employee.pay(salary)
            @funding -= salary
        else
            raise "error"
        end
    end

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += salaries[employee.title]
        end
        sum/size
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)

        @funding += startup.funding
        @salaries = startup.salaries.merge(salaries)
        @employees.push(*startup.employees)
        startup.close
    end



end
