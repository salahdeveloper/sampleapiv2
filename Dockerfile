FROM mcr.microsoft.com/dotnet/sdk:5.0 as build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
EXPOSE 55
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet","SampleApi.dll"]
