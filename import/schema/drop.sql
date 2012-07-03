alter table combo drop foreign key FK5A7318E69CBC6D5;
alter table combo drop foreign key FK5A7318EFCE9A7E1;
alter table combo drop foreign key FK5A7318EF93C805D;
alter table combo drop foreign key FK5A7318E63A4BBD2;
alter table doc drop foreign key FK1853897381E73;
alter table doc drop foreign key FK185381FC434AE;
alter table doc drop foreign key FK185387758376B;
alter table doc_context drop foreign key FK30EBA9A8C7230C87;
alter table identifier drop foreign key FK9F88ACA9F1F42470;
alter table identifier_occurrence drop foreign key FKF0533F279B08D7A5;
alter table identifier_occurrence drop foreign key FKF0533F27CDDD0AFF;
alter table identifier_occurrence drop foreign key FKF0533F279DF8E280;
alter table identifier_occurrence drop foreign key FKF0533F27B37DC426;
alter table issue_entitlement drop foreign key FK2D45F6C7330B4F5;
alter table issue_entitlement drop foreign key FK2D45F6C775F8181E;
alter table issue_entitlement drop foreign key FK2D45F6C72F4A207;
alter table license drop foreign key FK9F08441F144465;
alter table license drop foreign key FK9F0844168C2A8DD;
alter table org_role drop foreign key FK4E5C38F1E646D31D;
alter table org_role drop foreign key FK4E5C38F199CCEB1A;
alter table org_role drop foreign key FK4E5C38F1879D5409;
alter table org_role drop foreign key FK4E5C38F14F370323;
alter table org_role drop foreign key FK4E5C38F11960C01E;
alter table package drop foreign key FKCFE534462A381B57;
alter table package drop foreign key FKCFE53446A19A2161;
alter table package drop foreign key FKCFE5344692580D5F;
alter table platform drop foreign key FK6FBD68736DC6881C;
alter table platform drop foreign key FK6FBD6873E3F2DAD4;
alter table platformtipp drop foreign key FK9544A28C581DD6E;
alter table platformtipp drop foreign key FK9544A2810252C57;
alter table refdata_value drop foreign key FKF33A596F18DAEBF6;
alter table subscription drop foreign key FK1456591D7D96D7D2;
alter table subscription drop foreign key FK1456591D6297706B;
alter table subscription drop foreign key FK1456591DE82AEB63;
alter table subscription_package drop foreign key FK5122C72467963563;
alter table subscription_package drop foreign key FK5122C7241B1C4D60;
alter table title_instance drop foreign key FKACC69C334E5D16;
alter table title_instance drop foreign key FKACC69C66D9594E;
alter table title_instance_package_platform drop foreign key FKE793FB8F54894D8B;
alter table title_instance_package_platform drop foreign key FKE793FB8F40E502F5;
alter table title_instance_package_platform drop foreign key FKE793FB8F810634BB;
alter table title_instance_package_platform drop foreign key FKE793FB8F16ABD6D1;
alter table title_instance_package_platform drop foreign key FKE793FB8F3E48CC8E;
drop table if exists alert;
drop table if exists combo;
drop table if exists dataload_file_instance;
drop table if exists dataload_file_type;
drop table if exists doc;
drop table if exists doc_context;
drop table if exists identifier;
drop table if exists identifier_namespace;
drop table if exists identifier_occurrence;
drop table if exists issue_entitlement;
drop table if exists license;
drop table if exists org;
drop table if exists org_role;
drop table if exists package;
drop table if exists platform;
drop table if exists platformtipp;
drop table if exists refdata_category;
drop table if exists refdata_value;
drop table if exists subscription;
drop table if exists subscription_package;
drop table if exists title_instance;
drop table if exists title_instance_package_platform;
drop table if exists registration_code;
drop table if exists role;
drop table if exists user;
drop table if exists user_role;
drop table if exists property_definition;
drop table if exists property_value;
drop table if exists user_org;
drop table if exists object_property;
drop table if exists type_definition;
drop table if exists ftcontrol;
