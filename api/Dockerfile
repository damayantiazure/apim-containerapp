#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["NeptureWebAPI/NeptureWebAPI.csproj", "NeptureWebAPI/"]
RUN dotnet restore "NeptureWebAPI/NeptureWebAPI.csproj"
COPY . .
WORKDIR "/src/NeptureWebAPI"
RUN dotnet build "NeptureWebAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NeptureWebAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NeptureWebAPI.dll"]

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ping-app.csproj", "."]
RUN dotnet restore "ping-app.csproj"
COPY . .
RUN dotnet build "ping-app.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ping-app.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ping-app.dll"]