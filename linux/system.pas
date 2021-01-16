unit system;

interface

type
  cardinal  = 0..$FFFFFFFF;
  hresult   = cardinal;
  dword     = cardinal;
  integer   = longint;
  pchar     = ^char;

var
  ExitCode  : Longint; public name 'operatingsystem_result';

implementation

(*
procedure FPC_INITIALIZEUNITS; assembler; nostackframe; [public, alias: 'FPC_INITIALIZEUNITS'];
//begin
//end;
asm
end;

procedure FPC_DO_EXIT; assembler; nostackframe; [public, alias: 'FPC_DO_EXIT'];
//begin
//end;
asm
end;
*)

procedure FPC_INITIALIZEUNITS; [public, alias: 'FPC_INITIALIZEUNITS'];
begin
end;

procedure FPC_DO_EXIT; [public, alias: 'FPC_DO_EXIT'];
begin
end;

end.


