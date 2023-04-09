ARG VERSION=7.0.103

FROM mcr.microsoft.com/dotnet/aspnet:7.0.3-bullseye-slim-arm64v8 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:$VERSION-bullseye-slim AS build
WORKDIR /src
COPY ["BapWeb/BapWeb.csproj", "BapWeb/"]
RUN dotnet restore "BapWeb/BapWeb.csproj"
COPY . .
WORKDIR "/src/BapWeb"
RUN dotnet restore "BapWeb.csproj"
RUN dotnet build "BapWeb.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BapWeb.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app

COPY --from=publish /app/publish .
ENV DOTNET_RUNNING_IN_CONTAINER=true \
  ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "BapWeb.dll"]
