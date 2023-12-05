CREATE OR REPLACE FUNCTION user_register_secure(username text, passwd text)
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
        elsif (
            select char_length(passwd) < 16
            -- OR via Regex:
            -- select passwd SIMILAR TO '\S{16,}'
        ) or (
            select count(regexp_match(passwd, '(([0-9].*)+){3,}')) = 0
        ) or (
            select count(regexp_match(passwd, '(([a-z].*)+){4,}')) = 0
        ) or (
            select count(regexp_match(passwd, '(([A-Z].*)+){4,}')) = 0
        ) or (
            select count(regexp_match(passwd, '(([!@#$%^&*].*)+){4,}')) = 0
        )
        then return 'ERROR: password too simple:
            - must have 16+ characters;
            - must have 3+ number characters;
            - must have 4+ lowercase characters;
            - must have 4+ uppercase characters;
            - must have 4+ special characters (!, @, #, $, %, ^, &);
        ';
        else
            insert into users (username, passwd) values ( username, md5(passwd) );
            return 'SUCCESS';
        end if;
    end;
    $$;