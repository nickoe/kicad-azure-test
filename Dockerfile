#hack for netapi32.dll https://github.com/StefanScherer/dockerfiles-windows/tree/master/golang-issue-21867
FROM mcr.microsoft.com/windows/servercore:ltsc2019 as core


FROM mcr.microsoft.com/powershell:nanoserver-1809

COPY --from=core /windows/system32/netapi32.dll /windows/system32/netapi32.dll

RUN cd
RUN dir


RUN pwsh -Command Write-Host "Fisk"

RUN dir

COPY 7zip.exe .
COPY 7zip.msi .

RUN dir
RUN mkdir "C:\_tools"
#RUN start /wait 7zip.exe /SD /D="C:\_tools\sss"

#RUN start /wait 7zip.msi /q INSTALLDIR="C:\_tools"

#RUN pwsh -Command Start-Process msiexec.exe -Wait -ArgumentList '/I 7zip.msi /quiet INSTALLDIR="C:\_tools"'


RUN dir _tools
#RUN 7za.exe
RUN dir "C:\Program Files"
#RUN C:\_tools\7za.exe --help

COPY cmake.zip .
RUN pwsh -Command  $ProgressPreference = 'SilentlyContinue' ; Expand-Archive -Path cmake.zip -DestinationPath _tools -Force
RUN dir _tools
RUN pwsh -Command Write-Host "Cmake install passsed"
RUN dir _tools\cmake-3.14.4-win64-x64\bin
RUN C:\_tools\cmake-3.14.4-win64-x64\bin\cmake.exe --version

#RUN setx path "%path%;C:\_tools\cmake-3.14.4-win64-x64\bin"
#RUN setx PATH 'C:\_tools\cmake-3.14.4-win64-x64\bin;%PATH%'
#RUN cmake.exe --version


# local script
RUN mkdir .\kicad-winbuilder
COPY kicad-winbuilder\ .\kicad-winbuilder\
COPY KiCad-Winbuilder.cmake kicad-winbuilder\KiCad-Winbuilder.cmake
RUN cd kicad-winbuilder && dir
RUN cd kicad-winbuilder && C:\_tools\cmake-3.14.4-win64-x64\bin\cmake.exe --trace -Dx86_64=ON  -P KiCad-Winbuilder.cmake

#RUN cd kicad-winbuilder && C:\_tools\cmake-3.14.4-win64-x64\bin\cmake.exe --trace -P KiCad-Winbuilder.cmake
RUN dir kicad-winbuilder\msys64\mingw64\bin
