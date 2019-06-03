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
<li>Reports: Work Calendar, Employee Report, Workflow Report</li>
</ul>

<h2>Screenshots:</h2>
<table>
<tr>
	<td>
<img src="https://raw.githubusercontent.com/optimajet/HRM/master/Resources/Dashboard.png" alt="Dashboard" width="200" style="
    border: 1px solid;
    border-color: #3e4d5c;">
</td><td>
<img src="https://raw.githubusercontent.com/optimajet/HRM/master/Resources/EmployyeProfile.png" alt="Emloyee's profile" width="200" style="
	    border: 1px solid;
	    border-color: #3e4d5c;">
</td><td>
<img src="https://github.com/optimajet/HRM/blob/master/Resources/BusinessTrip.png" alt="Business Trip" width="200" style="
	    border: 1px solid;
	    border-color: #3e4d5c;">
		</td>
</tr>
</table>

<h2>Development:</h2>
<ul>
	<li><a href="https://www.microsoft.com/net/download">.NET Core SDK >=2.1</a></li>
	<li><a href="https://www.visualstudio.com/free-developer-offers/">Visual Studio 2017 (free)</a></li>
	<li><a href="https://www.jetbrains.com/rider/">JetBrains Rider</a></li>
</ul>

<h2>How to run:</h2>
The sample supports MS SQL and PosgreSQL as storage.<br/>
1. You need to set up Database, restore backup OR (!!!) execute script.<br/>
1.1. Backup<br/>
1.1.1. MSSQL: DB\MSSQL\backup.bak<br/>
1.1.2. PostgreSQL: DB\PostgreSQL\backup.sql<br/>
1.2. The order of execution of scripts:<br/>
1.2.1. DWKitScript.sql<br/>
1.2.2. Workflow_CreatePersistenceObjects.sql<br/>
1.2.3. CreateObjects.sql<br/>
1.2.4. FillData.sql<br/>
2. Open hrm.sln file via Visual Studio 2017 or JetBrains Rider<br/>
3. Check a connection string in OptimaJet.DWKit.StarterApplication\appsettings.json (You might use MS SQL or PosgreSQL connection string's format)<br/>
4. Run OptimaJet.DWKit.StarterApplication (Press F5 for Visial Studio).

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

<h2>Information:</h2>
<b>Official web-site</b> - <a href="https://dwkit.com/solutions/hrm/">https://dwkit.com/solutions/hrm/</a><br/>
<b>Documentation</b> - <a href="https://dwkit.com/documentation/">https://dwkit.com/documentation/</a><br/><br/>
<b>Demo</b> - <a href="http://hr.dwkit.com/">http://hr.dwkit.com/</a><br/>
<br/><br/>

For commercial use, please contact <a href="mailto:sales@optimajet.com?subject=DWKit question from github">sales@optimajet.com</a><br/>

<b>Demo license (valid until 31.12.2019):</b>
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
