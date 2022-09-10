import ballerinax/mysql;

string USER="root";
string PASSWORD="Raisoni@123";
string HOST="localhost";
int PORT=3306;
string DATABASE="employee_mgmt";
public function dbConnection() returns mysql:Client|error{
    final mysql:Client dbClient = check new
            (host=HOST, 
            user=USER, 
            password=PASSWORD, 
            port=PORT, 
            database=DATABASE);
    
    return dbClient;
}
