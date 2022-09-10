import data_service_in_ballerina.employee_model;
import ballerina/sql;
import ballerinax/mysql;
import data_service_in_ballerina.db_connection;
public function addEmployee(employee_model:employee newEmployee) returns string|error{
    mysql:Client|error dbConn = makeDbConnection();
    if dbConn is mysql:Client{
        sql:ParameterizedQuery insertSqlQuery = `insert into employee(name,department) 
        values(${newEmployee.name},${newEmployee.department});`;
        sql:ExecutionResult|sql:Error exec = dbConn -> execute(insertSqlQuery);
        if exec is sql:ExecutionResult{
            return "Employee Inserted successfully";
        }else{
            return error("Error while inserting employee");
        }
    }else{
        return error("Error while inserting employee");
    }
}

public function getEmployeeById(int id) returns employee_model:employee|error{
    mysql:Client|error dbConn = makeDbConnection();
    if dbConn is mysql:Client{
        sql:ParameterizedQuery selectQuery = `select * from employee 
        where id = ${id}`;
        employee_model:employee emp = check dbConn -> queryRow(selectQuery);
        return emp;
    }else{
        return error("Error while inserting employee");
    }
}

public function updateEmployee(int id,employee_model:employee updatedEmployee) returns string|error{
    mysql:Client|error dbConn = makeDbConnection();
    if dbConn is mysql:Client{
        sql:ParameterizedQuery updateSqlQuery = `update employee set name=${updatedEmployee.name},
        department=${updatedEmployee.department} where id=${id}`;
        sql:ExecutionResult|sql:Error exec = dbConn -> execute(updateSqlQuery);
        if exec is sql:ExecutionResult{
            return "Employee Updated successfully";
        }else{
            return error("Error while updating employee");
        }
    }else{
        return error("Error while updating employee");
    }
}

public function deleteEmployee(int id) returns string|error{
    mysql:Client|error dbConn = makeDbConnection();
    if dbConn is mysql:Client{
        sql:ParameterizedQuery deleteSqlQuery = `delete from employee where id = ${id}`;
        sql:ExecutionResult|sql:Error exec = dbConn -> execute(deleteSqlQuery);
        if exec is sql:ExecutionResult{
            return "Employee Deleted successfully";
        }else{
            return error("Error while deleting employee");
        }
    }else{
        return error("Error while deleting employee");
    }
}

public function getAllEmployee() returns employee_model:employee[]|error{
    mysql:Client|error dbConn = makeDbConnection();
    if dbConn is mysql:Client{
        sql:ParameterizedQuery selectSqlQuery = `select * from employee`;
        stream<employee_model:employee, sql:Error?> resultStream = dbConn -> query(selectSqlQuery);
        employee_model:employee[] employees = [];
        check from employee_model:employee emp in resultStream
        do{
            employees.push(emp);
        };
        check resultStream.close();
        return employees;
    }else{
        return error("Error while deleting employee");
    }
}

public function makeDbConnection() returns mysql:Client|error{
    return db_connection:dbConnection();
}
