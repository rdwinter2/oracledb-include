create or replace trigger sys.trace_user after logon on database disable
begin
  <<sql_trace>>
  begin
    if user in ('XXXXX') then
      execute immediate 'ALTER SESSION SET timed_statistics = true';
      execute immediate 'ALTER SESSION SET statistics_level = all';
      execute immediate 'ALTER SESSION SET max_dump_file_size = unlimited';
      execute immediate 'ALTER SESSION SET tracefile_identifier = ''' || USER || '''';
      execute immediate 'ALTER SESSION SET EVENTS ''10046 trace name context forever, level 12''';
      -- execute immediate 'ALTER SESSION SET EVENTS ''10053 trace name context forever, level 1''';
    end if;
  exception
    when others then
      null;
  end sql_trace;
  <<cursor_sharing>>
  begin
    if user in ('XXXXX') then
      execute immediate 'ALTER SESSION SET cursor_sharing = force';
    end if;
  exception
    when others then
      null;
  end cursor_sharing;
  <<no_push_pred>>
  begin
    if user in ('XXXXX') then
      execute immediate 'ALTER SESSION SET "_push_join_predicate" = false';
    end if;
  exception
    when others then
      null;
  end no_push_pred;
end;
/