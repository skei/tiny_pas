program test;

//----------------------------------------------------------------------
// opengl
//----------------------------------------------------------------------
  
type
  TGUID = Byte;
  Cardinal = LongWord;
  PChar = ^Char;
  Integer = ^LongInt;

//var
//  _HandleFinally : Byte;

// API
const
  kernel32  = 'kernel32.dll';
  user32    = 'user32.dll';
  gdi32     = 'gdi32.dll';
  opengl32  = 'opengl32.dll';
  
  GL_DEPTH_BUFFER_BIT   = $00000100;
  GL_COLOR_BUFFER_BIT   = $00004000; 
  GL_QUADS              = $0007;
  GL_TEXTURE_2D         = $0DE1;  
  GL_UNSIGNED_BYTE      = $1401;
  GL_LUMINANCE          = $1909;  
  GL_TEXTURE_MIN_FILTER = $2801;  
  GL_LINEAR             = $2601;
  
  // skei: removed _ prefixes, and @xx postfixes, because they gave errors...
  
  procedure ExitProcess(uExitCode:Cardinal); stdcall; external kernel32 name 'ExitProcess';
  function  GetTickCount : Cardinal; stdcall; external kernel32 name 'GetTickCount';
  function  CreateWindowEx(dwExStyle:Cardinal; lpClassName:PChar; lpWindowName:PChar; dwStyle:Cardinal; X,Y,nWidth,nHeight:LongInt; hWndParent,hMenu,hInstance:Cardinal; lpParam:Pointer): Cardinal; stdcall; external user32 name 'CreateWindowExA';
  function  PeekMessage(lpMsg:Pointer; hWnd,wMsgFilterMin,wMsgFilterMax,wRemoveMsg:Cardinal) : Boolean; stdcall; external user32 name 'PeekMessageA';
  function  GetAsyncKeyState(vKey:LongInt) : SmallInt; stdcall; external user32 name 'GetAsyncKeyState';
  function  GetDC(hWnd:Cardinal) : Cardinal; stdcall; external user32 name 'GetDC';
  function  ChoosePixelFormat(DC:Cardinal; p2:Pointer) : LongInt; stdcall; external gdi32 name 'ChoosePixelFormat';
  function  SetPixelFormat(DC:Cardinal; PixelFormat:LongInt; FormatDef:Pointer) : Boolean; stdcall; external gdi32 name 'SetPixelFormat';
  function  SwapBuffers(DC:Cardinal) : Boolean; stdcall; external gdi32 name 'SwapBuffers';
  function  wglCreateContext(DC:Cardinal) : Cardinal; stdcall; external opengl32 name 'wglCreateContext';
  function  wglMakeCurrent(DC,p2:Cardinal) : Boolean; stdcall; external opengl32 name 'wglMakeCurrent';  
  procedure glEnable(cap:Cardinal); stdcall; external opengl32 name 'glEnable';
  procedure glClear(mask:Cardinal); stdcall; external opengl32 name 'glClear';  
  procedure glLoadIdentity; stdcall; external opengl32 name 'glLoadIdentity';
  procedure glRotatef(angle,x,y,z:Single); stdcall; external opengl32 name 'glRotatef';    
  procedure glTexImage2D(target:Cardinal; level,components,width,height,border:LongInt; format,_type:Cardinal; data:Pointer); stdcall; external opengl32 name 'glTexImage2D';
  procedure glTexParameteri(target,pname:Cardinal; param:LongInt); stdcall; external opengl32 name 'glTexParameteri';
  procedure glBegin(mode:Cardinal); stdcall; external opengl32 name 'glBegin';
  procedure glEnd; stdcall; external opengl32 name 'glEnd';
  procedure glVertex2s(x,y:SmallInt); stdcall; external opengl32 name 'glVertex2s';
  procedure glColor4ub(r,g,b,a:Byte); stdcall; external opengl32 name 'glColor4ub';
  procedure glTexCoord2s(s,t:SmallInt); stdcall; external opengl32 name 'glTexCoord2s';  
  procedure glOrtho(left,right,bottom,top,znear,zfar:Double); stdcall; external opengl32 name 'glOrtho';

//----------------------------------------------------------------------

var
  DC  : Cardinal;
  pfd : array [0..9] of Cardinal;
  Msg : array [0..4] of Cardinal;
  Tex : array [0..256 * 256 - 1] of Byte;
  i   : LongInt;//Integer;

begin
  // Init OpenGL
  pfd[1] := $25;
  DC := GetDC(CreateWindowEx(0, 'static', nil, Cardinal($90000000), 0, 0, 640, 480, 0, 0, 0, nil));
  SetPixelFormat(DC, ChoosePixelFormat(DC, @pfd), @pfd);
  wglMakeCurrent(DC, wglCreateContext(DC));
  // Init Texture
  for i := 0 to (256 * 256 - 1) do
  begin
    Tex[i] := (i mod 256) xor (i div 256);
  end;
  glEnable(GL_TEXTURE_2D);
  glTexImage2D(GL_TEXTURE_2D, 0, 1, 256, 256, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, @Tex);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  // Main Loop 
  repeat
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glLoadIdentity;  
    glOrtho(-4, 4, -3, 3, 0, 1);
    glRotatef(GetTickCount mod 360000 / 10, 0, 0, 1);
    // Draw Quad
    glBegin(GL_QUADS);
      glTexCoord2s(0, 0); glColor4ub(255, 0, 0, 255); glVertex2s(-2, -2);
      glTexCoord2s(1, 0); glColor4ub(0, 255, 0, 255); glVertex2s( 2, -2);
      glTexCoord2s(1, 1); glColor4ub(0, 0, 255, 255); glVertex2s( 2,  2);
      glTexCoord2s(0, 1); glColor4ub(80, 0, 80, 255); glVertex2s(-2,  2);
    glEnd;
    SwapBuffers(DC);    
    PeekMessage(@Msg, 0, 0, 0, 1);
  until (GetAsyncKeyState(27) <> 0);
  ExitProcess(0);
end.

//----------------------------------------------------------------------
// do-nothing
//----------------------------------------------------------------------

//begin
//end.
