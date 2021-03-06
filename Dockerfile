﻿# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY . .
RUN dotnet restore

# Copy everything else and build
RUN dotnet build -c:Release -o:out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Real.WebApi.dll"]