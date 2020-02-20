/* OptimaJet
 * DWKIT HRM
 * https://dwkit.com/solutions/hrm/
 */

DWKit HRM is a comprehensive, yet simple implementation of DWKit that allows you to manage your human resources whether you are an SMB or a large enterprise.

DWKit Human Resource Management provides company owners and managers with an ability to easily control and monitor employee information and statuses.

Besides, it enables employees to create and manage dynamic events and view information about their colleagues.

Users by default:
- admin (login - admin, password - 1)
- HR Director (login - hrdirector, password - 1)
- HR Manager (login - manager, password - 1)
- Director (login - director, password - 1)
- Accountant (login - accountant, password - 1)
- User 1 (login - user1, password - 1)
- User 2 (login - user2, password - 1)
- User 3 (login - user3, password - 1)
- User 4 (login - user4, password - 1)
- User 5 (login - user5, password - 1)

Official web site - https://dwkit.com/solutions/hrm/
Demo - https://hr.dwkit.com/
Email: sales@optimajet.com


How to launch via docker
-----------------
1) Run the startascontainer script
    For Windows:
        startascontainer.bat

    For Linux/MacOS:
	chmod +x docker-files/wait-for-postgres.sh
        chmod +x startascontainer.sh
        ./startascontainer.sh

This script build this dwkit's solution and run it with Postgres database.

2) Open the following url in your browser: http://localhost:48800

To access the application, use the following default access parameters:
Login: admin
Password: 1


How to launch it with a custom database
-----------------
1) Set up a database for DWKit. It supports MS SQL, Oracle, PostgreSQL. You need to run scripts from sql folder. You can find names of the scripts in sql/<type of DB>/readme.txt file.
2) Check the connection string to the database in the config.cfg file
MS SQL Server example:
ConnectionString=Data Source=(local);Initial Catalog=dwkit;Integrated Security=False;User ID=sa;Password=1

PostgreSQL example:
ConnectionString=User ID=postgres;Password=1;Host=localhost;Port=5432;Database=dwkit;

3) Run the starter script
    For Windows:
        start.bat

    For Linux/MacOS:
        chmod +x start.sh
        ./start.sh

4) Open the folloing url in your browser: http://localhost:48800

To access the application, use the following default access parameters:
Login: admin
Password: 1


How to update your solution based on dwkit
-----------------
1) Run updatesolution script

For Windows:
    Run updatesolution_run.bat

For Linux/MacOS (this way requires PowerShell https://github.com/PowerShell/PowerShell):
    pwsh updatesolution.ps1

2) Enter the path to your application.
3) Don't forget update database if it's necessary.
4) Rebuild your solution

How to rebuild
-----------------
For Windows:
    Run buildandstart.bat

For Linux/MacOS:
    chmod +x buildandstart.sh
    ./buildandstart.sh

How to run in Visual Studio
-----------------
1) Open dwkit.sln in Visual Studio or JetBrains Rider
2) Check the connection string to the database in the OptimaJet.DWKit.StarterApplication\appsettings.json file, ConnectionStrings section
3) Run OptimaJet.DWKit.StarterApplication project


Official web site - https://dwkit.com
Documentation - https://dwkit.com/documentation/
Demo - https://demo.dwkit.com
For technical questions, please contact support@optimajet.com
For commercial use, please contact sales@optimajet.com
