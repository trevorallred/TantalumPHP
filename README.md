Tantalum
========

Tantalum is an open source, PHP based web application builder that allows business analysts to rapidly create and deploy fully functional enterprise web applications.

It is inspired by the work done by [TenFold Corporation](http://www.tenfold.com/) in the 1990s and Microsoft Access. Think of Tantalum as a web-based version of Microsoft Access.

Repository
----------
Currently this project's source code is being hosted at http://github.com/trevorallred/TantalumPHP

License
----------
Tantalum is license under the Eclipse Public License (EPL). In short, the EPL is a business-friendly free software license. You can use, modify, copy and distribute the work and modified versions, however, any changes should be released.

Prerequisites
------------
* MySQL 5.1+
* PHP 5.3+
* Apache 2.x

Getting Started with a Developer Installation
---------------------------------
1. [Download the latest version of WAMP](http://www.wampserver.com/en/download.php)
2. Install WAMP to C:\wamp\
3. If you're only going to run Tantalum, then you can just download TantalumPHP and skip to step 7
4. If you're going to want to enhance the Tantalum Core, then you'll need to [install Git](http://help.github.com/win-set-up-git/)
When installing Git, I picked the Unix line end style, but I'm not sure it will matter on your OS if you use Eclipse.
5. Signup for a Github account and become a Collaborator on the TantalumPHP project or fork the project. I'm still not sure which is the right approch. See http://help.github.com/fork-a-repo/
6. Download source and put it into C:\wamp\www\tantalum\
7. Download and install a MySQL administration tool such as Toad for MySQL or SQL Yog.
http://toadsoft.com/toadmysql/
http://www.webyog.com/en/downloads.php
8. Create a new database called tantalum_meta and load it using install.sql
9. Edit your settings.php file
10. Start your apache server and you should be able to go to http://localhost/tantalum/
11. Download and install a PHP Editor such as Zend or Eclipse. http://www.eclipse.org/pdt/downloads/
12. Create a new PHP Project pointing to C:\wamp\www\tantalum\
