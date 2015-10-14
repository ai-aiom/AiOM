use gim;
insert into auth_user(name, description, properties, account, password, state, email, time) value('administrator', '超级管理员', null, 'administrator', '200ceb26807d6bf99fd6f4f0d1ca54d4', 1 ,'' ,'1970-1-1 11:11:11');

insert into auth_user(name, description, properties, account, password, state, email, time) value('admin', '管理员', null, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1 ,'' ,'1970-1-1 11:11:11');

insert into auth_role(name, description) value('超级管理员' ,'超级管理员角色');

insert into auth_role(name, description) value('管理员' ,'管理员角色');

insert into auth_group(name, description) value('默认组' ,'默认组');

insert into auth_user_role_relation(user_id, role_id) value(1, 1);

insert into auth_user_role_relation(user_id, role_id) value(2, 2);

insert into auth_user_group_relation(user_id, group_id) value(1, 1);

insert into auth_user_group_relation(user_id, group_id) value(2, 1);

insert into site_datacenter(id, name, description) value('1', '默认', '默认的数据中心');

insert into site_location(id, name, description, datacenter_id) value('1', '默认', '默认的机房', '1');

use aiom
insert into aiom_machine_module(id, name, machine_type) value('1', 'NAMENODE', '1');

insert into aiom_machine_module(id, name, machine_type) value('2', 'DATANODE', '1');

insert into aiom_machine_module(id, name, machine_type) value('3', 'GTM', '2');

insert into aiom_machine_module(id, name, machine_type) value('4', 'LVS', '2');

insert into aiom_machine_module(id, name, machine_type) value('5', 'DATANODE', '2');

insert into aiom_machine_module(id, name, machine_type) value('6', 'DATANODE-SLAVE', '2');

insert into aiom_machine_module(id, name, machine_type) value('7', 'DIDB', '2');

insert into aiom_machine_module(id, name, machine_type) value('8', 'KEEP-ALIVE', '2');

insert into aiom_machine_module(id, name, machine_type) value('9', 'CONTROL-IN-DATA', '2');

insert into aiom_machine_module(id, name, machine_type) value('10', 'GRM-PROXY', '2');

insert into aiom_machine values(1, '默认一体机', '默认一体机', 1, '');