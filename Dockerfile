
FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /app

#copy the csproj and return the distinct layers
COPY *.csproj ./
RUN dotnet restore

#copy evertying else and build
COPY . ./
RUN dotnet publish -c Release -o out

#build runtime image
FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runtime

WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT [ "dotnet", "app-api.dll" ]