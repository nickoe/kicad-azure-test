FROM mcr.microsoft.com/powershell
RUN dir
RUN pwsh echo Fisk


# Install Chocolatey
RUN powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

# New Powershell, so choco is available 
SHELL ["powershell"]

# Choco disable upload progress 
RUN choco feature disable --name showDownloadProgress

RUN choco --help
#RUN git clone https://github.com/KiCad/kicad-winbuilder.git
#RUN cd kicad-winbuilder
#RUN dir
