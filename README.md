# Secure Application Design

## Project Summary
This project  focuses on designing and deploying a secure, scalable application using AWS infrastructure with an emphasis on security best practices. The architecture consists of two main components:
- Apache Server: Serves an asynchronous HTML+JavaScript client over a secure TLS connection, ensuring data integrity and confidentiality during downloads.
- Spring Framework: Provides backend RESTful API services, also secured with TLS for safe communication between the client and server.


## System Architecture
```
Security/
├── src/
│   ├── main/
│      ├── java/
│       │   └── com/
│       │       └── mycompany/
│       │           └── securityapp/
│       │               ├── controller/
│       │               │   └── AuthController.java  
│       │               ├── dto/
│       │               │   └── LoginRequest.java     
│       │               ├── SecurityAppApplication.java
│       │               ├── URLReader
│       │               └── CorsConfig 
│       └── resources/
│           ├── application.properties
│           ├── mi-certificado.cer
│           └── mi-certificado.p12
├── pom.xml  
└── Dockerfile 
```
 


# Diagrama de Despliegue en AWS

```
+-----------------------+       +-----------------------------+
|   User's Browser      | <---> |    AWS EC2 Instance 1       |
| (Async HTML+JS Client)|       |  (Apache Server - Frontend) |
+-----------------------+       +-----------------------------+
                                                |
                                                | (HTTPS)
                                                v
                             +-----------------------------------+
                             |    AWS EC2 Instance 2 (Backend)   |
                             |   (Dockerized Spring API Server)  |
                             +-----------------------------------+
```

# Deployment Instructions

## 1. Configure the EC2 Instance for Apache (Frontend)
##### Configure Apache for HTTPS:

```dockerfile
sudo yum update -y
sudo yum install -y httpd mod_ssl openssl
```
#####  Generate TLS Certificates:
```
sudo yum install -y epel-release
sudo yum install certbot -y
```
##### Set up the website
Make sure to upload the static files (HTML, JS, CSS) to the appropriate directory (/var/www/html)

## 2. Configure the EC2 Instance for Docker + Spring (Backend)


#####  Install Docker
```
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
```

##### Build and run the Docker container for Spring:
On the backend EC2 instance, create a Dockerfile for your Spring application
```
FROM eclipse-temurin:22-jdk
WORKDIR /app
COPY target/Security-1.0-SNAPSHOT.jar app.jar
COPY src/main/resources/keystore.p12 /app/keystore.p12
EXPOSE 5000
ENTRYPOINT ["java", "-jar", "app.jar"]
```

##### Build and run the Docker container:
```
docker build -t [username]/[repository] .
docker push [username]/[repository] 
docker pull [username]/[repository] 
docker run -d -p 5000:5000 [username]/[repository] 
```

## 3. Connect Frontend with Backend
##### Update the API URL in the Frontend:
In your JavaScript file (frontend), make sure the requests to the backend point to the public IP of the Backend EC2 Instance.

## 4. Test the functionality:
Open your browser and access the URL of your frontend (https://[EC2-Apache-ip]).

# Evidence
### Web Running





https://github.com/user-attachments/assets/3056c1cf-4b2e-4c06-a5ae-958203a45529





