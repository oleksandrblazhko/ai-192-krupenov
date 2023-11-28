CREATE OR REPLACE FUNCTION user_register(username text, passwd text)
    RETURNS text
    LANGUAGE plpgsql
    AS $$
    begin
        if (
            select count(*)
            from richelieu_top20k_passwords
            where password = passwd
        ) > 0
        then return 'ERROR: password matches a commonly used password.';
        else
            insert into users (username, passwd) values ( username, md5(passwd) );
            return 'SUCCESS';
        end if;
    end;
    $$;