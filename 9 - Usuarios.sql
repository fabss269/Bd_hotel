-- CREAR USUARIOS
create 
    user user_admin 
    with password 'Administrador';
create 
    user user_fpm 
    with password 'passwordFPM';
create 
    user user_lgs 
    with password 'passwordLGS';
create 
    user user_jpd 
    with password 'passwordJPD';
create 
    user user_fcv 
    with password 'passwordFCV';

-- CREAR GRUPOS
create 
    group group_users
    user user_fpm, user_lgs, user_jpd, user_fcv; 

-- DAR PERMISOS

grant 
    all privileges 
on all sequences in schema public 
to user_admin;
grant 
    all privileges  
on all tables in schema public 
to user_admin;
ALTER USER user_Admin CREATEDB;
ALTER USER user_Admin WITH SUPERUSER;

grant 
    all privileges 
on all tables in schema public 
to group_users;
grant 
    all privileges
on all sequences in schema public 
to group_users;
