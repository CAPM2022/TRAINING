using { epm.db } from  '../db/datamodel';
@readonly
entity ReadEmployeeSrv as projection on db.master.employees;