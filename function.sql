

create function get_uid(name char)
    return int 
    language plsql
    as
    $$
    uid int;
    begin
    select user_id into uid from Social_user where user_name = name;
    return uid;
    end;
    $$
