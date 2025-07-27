Für die Ausführung des Scripts wird ein gültiger AWS Account benötigt, dazu muss noch das AWS CLI installiert werden. 

Über die Terminal-Eingabe "aws configure" muss sich vor Script-Ausführung Authentifiziert werden. Hier wird der Public- und Private-Key des AWS Accounts benötigt.

Das Terraform Script checkt bei Route53 Domain Registration nicht, ob eine Domain verfügbar ist. Das muss vorab zum Beispiel mit dem AWS CLI überprüft werden:
        aws route53domains check-domain-availability --domain-name "deine-wunschdomain.com"

Die EC-2 Launch Template erwartet ein vorhandenes Key-Pair. Hierfür kann ein schon vorhandenes Paar genutzt werden oder ein neues erstellt werden:
Im Terminal:
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_aws_terraform

Dieses Script erstellt eine AWS Architektur, dass zum Hosten einer Website verwendet werden kann. Es werden folgende Dienste erstellt und gestartet:
Route 53
- Zur Domain-Registrierung
CloudFront
- CDN 
Amazon Certificate Manager
- Zertifikat für Load Balancer und CloudFront
S3 Bucket
- Dient als Speicher für Website / Index.html file. Hierüber laden erstellte EC2 Instanzen bei Launch die benötigten (Website-)Daten
VPC
- Virtual Private Cloud in zwei Availability Zones, mit je zwei Private- und Public Subnets. ACLs und ein S3 VPC-Endpoint.
AWS WAF
- Web Application Firewall als erste Sicherheitsmaßname
Security Group
- Security Groups für den Application Load Balancer und EC2 Instanzen
NAT-Gateway
- Ein NAT-Gateway, das den Diensten in Private Subnets den Internet-Zugang ermöglicht. Das NAT-Gateway befindet sich im ersten Public Subnet.
ALB / Load Balancer
- Appliaction Load Balancer der eingehenden Datenverkehr an die EC2 Instanzen weiterleitet und deren Gesundheitszustand überprüft
EC2 Launch Template

Auto Scaling Group

CloudFront

