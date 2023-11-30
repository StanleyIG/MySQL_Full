student@Ubuntu-MySQL-VirtualBox:~$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 5.7.25-0ubuntu0.16.04.2 (Ubuntu)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE example
    -> ;
Query OK, 1 row affected (0,00 sec)

mysql> SHOW DATABASES
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| example            |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0,00 sec)
mysql> USE example
Database changed
mysql> SHOW TABLES
    -> ;
Empty set (0,00 sec)

mysql> CREATE TABLE users (id INT, name CHAR);
Query OK, 0 rows affected (0,11 sec)
mysql> SHOW TABLES
    -> ;
+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0,00 sec)

mysql> DESCRIBE users
    -> ;
+-------+---------+------+-----+---------+-------+
| Field | Type    | Null | Key | Default | Extra |
+-------+---------+------+-----+---------+-------+
| id    | int(11) | YES  |     | NULL    |       |
| name  | char(1) | YES  |     | NULL    |       |
+-------+---------+------+-----+---------+-------+
2 rows in set (0,02 sec)
mysql> CREATE DATABASE sample
    -> ;
Query OK, 1 row affected (0,00 sec)

mysql> SHOW DATABASES
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| example            |
| mysql              |
| performance_schema |
| sample             |
| sys                |
+--------------------+
6 rows in set (0,00 sec)

mysql> \q
Bye

student@Ubuntu-MySQL-VirtualBox:~$ mysqldump example > sample.sql
student@Ubuntu-MySQL-VirtualBox:~$ mysql sample < sample.sql
student@Ubuntu-MySQL-VirtualBox:~$ ls
examples.desktop  Видео      Загрузки     Музыка         Рабочий стол
sample.sql        Документы  Изображения  Общедоступные  Шаблоны
student@Ubuntu-MySQL-VirtualBox:~$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 31
Server version: 5.7.25-0ubuntu0.16.04.2 (Ubuntu)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE sample
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES
    -> ;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0,00 sec)


