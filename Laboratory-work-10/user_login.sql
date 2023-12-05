CREATE OR REPLACE FUNCTION user_login(v_username text, v_passwd text)
    RETURNS text
    LANGUAGE plpgsql
    AS $$
    DECLARE
        v_token varchar;
        v_user_id integer;
    BEGIN
        select users.user_id into v_user_id 
        from users
        where
            users.username = v_username
            and users.passwd = md5(v_passwd);
        if not found then 
            return 'User ' || v_username || ' not found, or password does not match.';
        else 
            select md5(
                    inet_client_addr() :: varchar
                    ||
                    inet_client_port()
                    || 
                    pg_backend_pid()
                ) into v_token;
            insert
                into sso_tokens (user_id, token)
                values (v_user_id, v_token);
            return v_token;
	    end if;
    END;
    $$;