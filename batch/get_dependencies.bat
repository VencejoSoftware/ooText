@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning dxDUnit..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphi3rdParty%\dcpcrypt\ (
  @echo "Clonning dunit-agiledoxtestrunner..."
  git clone https://github.com/VencejoSoftware/DCPCrypt.git %delphi3rdParty%\dcpcrypt\
)

if not exist %delphiooLib%\ooGeneric\ (
  @echo "Clonning dunit-agiledoxtestrunner..."
  git clone https://github.com/VencejoSoftware/ooGeneric.git %delphiooLib%\ooGeneric\
)
