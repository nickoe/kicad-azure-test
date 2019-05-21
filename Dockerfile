FROM mcr.microsoft.com/powershell:nanoserver-1809
RUN dir
RUN pwsh -Command Write-Host "Fisk"

RUN pwsh -Command $PSVersionTable.PSVersion
RUN pwsh -Command Get-ExecutionPolicy


#RUN pwsh -Command \
#  $ErrorActionPreference = 'Stop'; \
#  (New-Object System.Net.WebClient).DownloadFile('https://github.com/dahlbyk/posh-git/zipball/master','posh-git.zip') ; \
#  Expand-Archive -Path posh-git.zip -DestinationPath ./

RUN dir
RUN pwsh -Command \
  $ErrorActionPreference = 'Stop'; \
  (New-Object System.Net.WebClient).DownloadFile('https://github.com/dahlbyk/posh-git/zipball/master','posh-git.zip') 
RUN dir


# Install Chocolatey
#RUN pwsh -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

# New Powershell, so choco is available 
#SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]


# Choco disable upload progress 
#RUN choco feature disable --name showDownloadProgress

#RUN choco -?
#RUN choco --help
RUN git clone https://github.com/KiCad/kicad-winbuilder.git
RUN cd kicad-winbuilder
RUN dir
RUN cmake -P KiCad-Winbuilder.cmake
