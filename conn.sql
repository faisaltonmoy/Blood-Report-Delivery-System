drop database link site1;

create database link site1
 connect to system identified by "123456"
 using '(DESCRIPTION =
	   (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
		 (HOST = 10.0.2.15)
		 (PORT = 1622))
	    )
	   (CONNECT_DATA =
         (SID = XE)
	    )
    )'
;  

drop database link server1;

create database link server1
 connect to system identified by "123456"
 using '(DESCRIPTION =
	   (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
		 (HOST = 192.168.0.124)
		 (PORT = 1623))
	    )
	   (CONNECT_DATA =
         (SID = XE)
	    )
    )'
; 