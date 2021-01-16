unit sysinitpas;

interface

implementation

procedure PASCALMAIN; external name 'PASCALMAIN';

procedure ExitProcess(ExitCode: longint); stdcall; external 'kernel32.dll' name 'ExitProcess';

procedure Entry; [public, alias: '_mainCRTStartup'];
begin
   PASCALMAIN;
   ExitProcess(0);
end;

end.