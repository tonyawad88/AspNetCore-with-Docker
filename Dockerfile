FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnetcoreapp.dll"]


# docker build -t aspnetcoreapp/v1 .
# docker build -t aspnetcoreapp/v2 .

# docker save -o aspnetcoreapp.tar aspnetcoreapp
# docker save -o aspnetcoreapp_v1.tar aspnetcoreapp/v1
# docker save -o aspnetcoreapp_v2.tar aspnetcoreapp/v2

# docker load --input aspnetcoreapp.tar
# docker load --input aspnetcoreapp_v1.tar
# docker load --input aspnetcoreapp_v2.tar

# docker run -d -p 8081:80 --name myapp aspnetapp
# docker run -d -p 8082:80 aspnetcoreapp/v1
# docker run -d -p 8082:80 aspnetcoreapp/v2

