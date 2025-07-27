# Terraform AWS Architektur: Webanwendung mit VPC, Auto Scaling und CDN

Dieses Terraform-Projekt erstellt eine skalierbare, hochverfügbare und sichere Webanwendungs-Infrastruktur in AWS. Es beinhaltet die Registrierung einer Domain in Route53, CloudFront Distribution, Lastverteilung via Load Balancer und eine VPC inklusive EC2 Instanzen und Scaling Group. Ein S3 Bucket ist als VPC-Endpoint verbunden. Eine WAF, Security Groups, Access Control Lists und AWS Zertifikate für eine sichere HTTPS Verbindung.

## Inhaltsverzeichnis

- Terraform AWS Architektur
- [Voraussetzungen](#voraussetzungen)
- [Architekturübersicht](#architekturübersicht)
- [Verwendete Terraform-Module](#verwendete-terraform-module)
- [Einrichtung und Bereitstellung](#einrichtung-und-bereitstellung)
- [Konfiguration](#konfiguration)
- [Bereinigung](#bereinigung)


## Voraussetzungen

Stelle sicher, dass die folgenden Tools und Zugänge auf deinem System vorhanden sind:

* **Terraform:** Version 1.0.0 oder neuer.
* **AWS CLI:** Konfiguriert mit den entsprechenden Zugangsdaten für dein AWS-Konto. Stelle sicher, dass der konfigurierte IAM-Benutzer die notwendigen Berechtigungen zur Erstellung der Ressourcen besitzt.
* **Git:** Zum Klonen des Repositorys.
* **Ein AWS-Konto:** Mit Administrator- oder entsprechenden IAM-Berechtigungen.
* **Domain-Name** Die Verfügbarkeit des gewünschten Domain-Namen muss zuvor überprüft werden, da keine Verfügbarkeitsprüfung im Code durchgeführt wird.
Überprüfung via Terminal AWS CLI:
aws route53domains check-domain-availability --domain-name "deine-wunschdomain.com"
* **SSH Key Pair** Die EC-2 Launch Template erwartet ein vorhandenes Key-Pair. Hierfür kann ein schon vorhandenes Paar genutzt werden oder ein neues erstellt werden:
Im Terminal:
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_aws_terraform

## Architekturübersicht

Die von diesem Terraform-Projekt bereitgestellte Architektur umfasst die folgenden Kernkomponenten:

* **Virtual Private Cloud (VPC):** Eine isolierte und sichere Netzwerkumgebung mit folgender Konfiguration:
	* **Subnetze:**
    	* **Öffentliche Subnetze:** Für Ressourcen, die direkt über das Internet erreichbar sein sollen.
    	* **Private Subnetze:** Für Backend-Ressourcen, die nicht direkt von außen zugänglich sein sollen.
	* **Internet Gateway (IGW):** Ermöglicht die Kommunikation zwischen der VPC und dem Internet.
	* **NAT Gateway:** Ermöglicht Instanzen in privaten Subnetzen den Zugriff auf das Internet.
* **Application Load Balancer (ALB):** Verteilt eingehenden Traffic auf die vorhandenen EC2-Instanzen.
* **Auto Scaling Group (ASG) und EC2 Launch Template:** Stellt sicher, dass die Anwendung je nach Last skaliert wird.
* **Security Groups** Firewall-Regeln zur Kontrolle des eingehenden und ausgehenden Verkehrs.
* **AWS WAF** Web Application Firewall als erste Schutzmaßnahme der Webanwendung
* **Route53** Amazon Domain-Namen-Registrierungsdienst
* **CloudFront** Content Delivery Network zur schnellen, weltweiten bereitstellung der Webanwendung
* **ACM** Certificate Manager zur Erstellung von SSL/TLS-Zertifikaten
* **S3 Bucket** Hoch skalierbarer S3 Cloud-Objektspeicher

AWS Architektur: https://i.imgur.com/86YSeF0.jpeg


## Verwendete Terraform-Module

Dieses Projekt nutzt die folgenden Terraform-Module, um die Code-Wiederverwendung und -Organisation zu verbessern:

* **modules/acm:** Certificate Manager erstellt SSL/TLS-Zertifikate in passenden Regionen für Application Load Balancer und CloudFront
* **modules/auto_scaling_group:** Auto Scaling Group die automatisch mit erstellten EC2 Launch Templates Instanzen erstellt oder beendet.
* **modules/cloudfront:** Cloud Delivery Network zur schnellen weltweiten Bereitstellung der Webanwendung
* **modules/ec2:** Erstellt eine Launch Template für EC2 Instanzen
* **modules/load_balancer:** Application Load Balancer verteilt eingehende Last auf nachfolgende EC2 Instanzen
* **modules/iam_roles:** Erstellt eine S3ReadOnly IAM-Role, die EC2-Instanzen zugewiesen werden.
* **modules/nat_gateway:** Ein NAT-Gateway wird in Public Subnet erstellt und ermöglicht Diensten in den Private Subnets den Internetzugang
* **modules/route53:** Registriert die übergebene Domain und erstellt Hosted Zone mit Records für root-Adresse und www-Adresse.
* **modules/s3:** Erstellt einen S3 Bucket Speicher, auf dem die Webanwendungs-Dateien gespeichert werden müssen.
* **modules/securitygroups:** Sicherheitsregeln, die eingehenden und ausgehenden Datenverkehr regeln für EC2 Instanzen und Load Balancer
* **modules/vpc:** Erstellt und Konfiguriert die VPC inklusive Subnets, Routing-Tables, Internet-Gateway und S3 VPC-Endpoint
* **modules/waf:** Erstellt eine WAF mit AWS Common Rule Set, IP Reputation List, Known Bad Inputs Rule Set sowie IP Rate Limit Rule.


## Einrichtung und Bereitstellung

Führe die folgenden Schritte aus, um die AWS-Infrastruktur mit Terraform bereitzustellen:

1.  **Repository klonen:**
    ```bash
    git clone https://github.com/No1ichi/terraform-aws-instance
    cd terraform-aws-instance
    ```
2.  **AWS CLI Anmeldung**
    Anmeldung bei AWS mithilfe des AWS CLI
    ```bash
    aws configure
    ```
3.  **Terraform initialisieren:**
    Navigiere in das Stammverzeichnis des Terraform-Projekts und   
    initialisiere es. Dies lädt die notwendigen Provider und Module 
    herunter.
    ```bash
    terraform init
    ```
3.  **Terraform-Plan überprüfen:**
    Erstelle einen Ausführungsplan, um zu sehen, welche Ressourcen 
    Terraform erstellen, ändern oder zerstören wird. Dies ist ein 
    wichtiger Schritt, um unerwartete Änderungen zu vermeiden.
    ```bash
    terraform plan
    ```
4.  **Terraform anwenden:**
    Wenn der Plan zufriedenstellend aussieht, wende die Konfiguration 
    an, um die Ressourcen in AWS zu erstellen.
    ```bash
    terraform apply
    ```
    Du wirst aufgefordert, `yes` einzugeben, um die Aktion zu 
    bestätigen.

## Konfiguration

Das Projekt kann über die `variables.tf`-Datei oder durch eine `terraform.tfvars`-Datei angepasst werden.

Hier sind die  wichtigsten konfigurierbaren Variablen:

* **`region` (string):** Die AWS-Region, in der die Ressourcen bereitgestellt werden sollen.
* **`domain_name` (string):** Der Name der Domain, die registriert und verwendet werden soll.
* **`tags` (string):** Tags um die Dienste zu markieren.
* **`admin_contacts` (string):** Kontaktdaten, die für die Domain-Registrierung benötigt werden.
* **`registrant_contacts` (string):** Kontaktdaten, die für die Domain-Registrierung benötigt werden.
* **`tech_contacts` (string):** Kontaktdaten, die für die Domain-Registrierung benötigt werden.
* **`s3_bucket_name` (string):** Der Name für den erstellten S3 Bucket
* **`vpc_cidr` (string):** Der CIDR-Block für die VPC
* **`public_subnets` (string):** Angabe der Availability Zones und CIDR-Blocks der Public Subnets
* **`private_subnets` (string):** Angabe der Availability Zones und CIDR-Blocks der Private Subnets
* **`vpc_endpoints` (string):** Einrichtung eines VPC Endpoints
* **`waf_name` (string):** Name der AWS WAF
* **`ssh_access_ip` (string):** Die IP-Adresse, die für den SSH-Zugriff auf die EC2-Instanzen freigeschaltet ist.
* **`alb_name` (string):** Name des Application Load Balancers
* **`public_key` (string):** Public Key, der für die SSH-Verbindung zu einer EC2 Instanz benötigt wird.
* **`launch_template_name` (string):** Name des EC2-Launch Templates
* **`asg_name` (string):** Name der Auto Scaling Group
* **`auto_scaling_size` (number):** Die Werte für die Auto Scaling Group für “min”, “max” und “desired size” an EC2 Instanzen 

## Bereinigung

Um alle von diesem Terraform-Projekt erstellten Ressourcen aus deinem AWS-Konto zu entfernen, führe den folgenden Befehl aus:

```bash
terraform destroy
```

Du wirst aufgefordert, yes einzugeben, um die Aktion zu bestätigen. Sei vorsichtig, da dies alle damit verbundenen Ressourcen dauerhaft löscht.
