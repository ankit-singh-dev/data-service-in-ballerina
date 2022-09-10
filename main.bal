import ballerina/http;
import data_service_in_ballerina.employee_model;
import data_service_in_ballerina.employee_service;

listener http:Listener httpListener = new(8089);

# A service representing a network-accessible API
# bound to port `8089`.
service /home on httpListener {

    resource function get getEmployee/[int id]() returns employee_model:employee|error{
        return employee_service:getEmployeeById(id);
    }

    resource function post addEmployee(@http:Payload employee_model:employee payload) returns string|error{
        return employee_service:addEmployee(payload);
    }

    resource function post updateStudent/[int id](@http:Payload employee_model:employee payload) returns string|error{
        return employee_service:updateEmployee(id,payload);
    }

    resource function get deleteEmployee/[int id]() returns string|error{
        return employee_service:deleteEmployee(id);
    }

    resource function get getAllEmployee() returns employee_model:employee[]|error{
        return employee_service:getAllEmployee();
    }
}
