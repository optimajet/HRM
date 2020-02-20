DWKit HRM
==================

DWKit HRM is a comprehensive, yet simple implementation of DWKit that allows you to manage your human resources whether you are an SMB or a large enterprise.

DWKit Human Resource Management provides company owners and managers with an ability to easily control and monitor employee information and statuses.

Besides, it enables employees to create and manage dynamic events and view information about their colleagues.

<h2>Features:</h2>
<ul>
<li>Employee catalogue</li>
<li>Employee card</li>
<li>Business processes: Business Trip, Sick leave, Vacation, Compensation, Recruitment</li>
<li>Reports: Employee Report, Workflow Report</li>
</ul>

<h2>Screenshots:</h2>
<table>
<tr>
	<td>
<img src="https://raw.githubusercontent.com/optimajet/HRM/master/Resources/dashboard.png" alt="Dashboard" width="200" style="
    border: 1px solid;
    border-color: #3e4d5c;">
</td><td>
<img src="https://github.com/optimajet/HRM/blob/master/Resources/businesstrip.png" alt="Business Trip" width="200" style="
	    border: 1px solid;
	    border-color: #3e4d5c;">
		</td><td>
<img src="https://raw.githubusercontent.com/optimajet/HRM/master/Resources/businesstrip-mobile.png" alt="Adaptive view" width="200" style="
	    border: 1px solid;
	    border-color: #3e4d5c;">
</td>
</tr>
</table>

<h2>Users by default:</h2>
<ul>
<li>admin (login - admin, password - 1)</li>
<li>HR Director (login - hrdirector, password - 1)</li>
<li>HR Manager (login - manager, password - 1)</li>
<li>Director (login - director, password - 1)</li>
<li>Accountant (login - accountant, password - 1)</li>
<li>User 1 (login - user1, password - 1)</li>
<li>User 2 (login - user2, password - 1)</li>
<li>User 3 (login - user3, password - 1)</li>
<li>User 4 (login - user4, password - 1)</li>
<li>User 5 (login - user5, password - 1)</li>
</ul>

<h2>How to launch via docker</h2>
-----------------
1) Run the startascontainer script
For Windows:
```
	startascontainer.bat
```
For Linux/MacOS:

```
chmod +x docker-files/wait-for-postgres.sh
chmod +x startascontainer.sh
./startascontainer.sh
```

This script build this dwkit's solution and run it with Postgres database.

2) Open the following url in your browser: http://localhost:48800

To access the application, use the following default access parameters:
Login: admin
Password: 1


<h2>How to launch it with a custom database</h2>
-----------------
1) Set up a database for DWKit. It supports MS SQL, Oracle, PostgreSQL. You need to run scripts from sql folder. You can find names of the scripts in sql/<type of DB>/readme.txt file.
2) Check the connection string to the database in the config.cfg file.

MS SQL Server example:
```
ConnectionString=Data Source=(local);Initial Catalog=dwkit;Integrated Security=False;User ID=sa;Password=1
```

PostgreSQL example:
```
ConnectionString=User ID=postgres;Password=1;Host=localhost;Port=5432;Database=dwkit;
```

3) Run the starter script

For Windows:
```
	start.bat
```

For Linux/MacOS:
```
	chmod +x start.sh
	./start.sh
```

4) Open the folloing url in your browser: http://localhost:48800

To access the application, use the following default access parameters:
Login: admin
Password: 1


<h2>How to update your solution based on dwkit</h2>

1) Run updatesolution script

For Windows:

```
    Run updatesolution_run.bat
```

For Linux/MacOS (this way requires PowerShell https://github.com/PowerShell/PowerShell):
```
    pwsh updatesolution.ps1
```

2) Enter the path to your application.
3) Don't forget update database if it's necessary.
4) Rebuild your solution

<h2>How to rebuild</h2>

1) Open dwkit.sln in Visual Studio or JetBrains Rider
2) Check the connection string to the database in the OptimaJet.DWKit.StarterApplication\appsettings.json file, ConnectionStrings section
3) Run OptimaJet.DWKit.StarterApplication project

For Windows:

```
	buildandstart.bat
```

For Linux/MacOS:

```
    chmod +x buildandstart.sh
	chmod +x start.sh
    ./buildandstart.sh
```

<h2>How to run in Visual Studio</h2>



<h2>Information:</h2>
<b>Official web-site</b> - <a href="https://dwkit.com/solutions/hrm/">https://dwkit.com/solutions/hrm/</a><br/>
<b>Documentation</b> - <a href="https://dwkit.com/documentation/">https://dwkit.com/documentation/</a><br/><br/>
<b>Demo</b> - <a href="http://hr.dwkit.com/">http://hr.dwkit.com/</a><br/>
<br/><br/>

For commercial use, please contact <a href="mailto:sales@optimajet.com?subject=DWKit question from github">sales@optimajet.com</a><br/>

<b>Demo license:</b>
<ul>
<li>Instances: 1</li>
<li>Users: 20</li>
<li>Forms: 30</li>
<li>Workflow: 5 schemes</li>
</ul>

<h2>System requirements:</h2>
<ul>
	<li>OS Windows/Linux/MacOS</li>
	<li>CPU 1 core 2 Ghz</li>
	<li>RAM 2 Gb</li>
	<li>HDD/SSD 10 Gb</li>
	<li><a href="https://www.microsoft.com/net/download">.NET Core Runtime >=2</a></li>
</ul>
