/*Defined Variables cannot contain an Ampersand &*/
/*Folder can be a mapped drive (C:, X:) or a network location (\\sharedfolder\subfolder1\subfolder2) for which you have permissions*/
define varfolder = 'C:\Oracle_Views'
define varowner = 'HR'

set pages 0
set lines 500
set trimspool on
set feedback off
set echo off
set verify off
set sqlformat ansiconsole
set FLUSH OFF



spool '&&varfolder\temp_script.sql'

prompt set echo off
prompt set pages 0
prompt set lines 500
prompt set trimspool on
prompt set feedback off
prompt SET sqlformat ansiconsole
prompt set termout off


select distinct 'spool ' || '"' || '&&varfolder\' || owner||'.'||view_name||'.sql' || '"' || ';' || chr(13) ||
        'SELECT text as "--' || view_name || '" from all_views where owner = '''||owner||''' and view_name = ''' || view_name || ''';' || chr(13)
as "--Script"
from all_views where owner = '&&varowner';

prompt set termout on
prompt spool off

set flush on
spool off


@'&&varfolder\temp_script.sql'
