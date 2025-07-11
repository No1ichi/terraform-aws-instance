Wichtig: Das Terraform Script checkt bei Route53 Domain Registration nicht, ob eine Domain verfügbar ist. Das muss vorab zum Beispiel mit dem AWS CLI überprüft werden:
        aws route53domains check-domain-availability --domain-name "deine-wunschdomain.com"



### In Modul die Namen abändern von spezifisch zu default ###
Load Balancer
pp_alb = alb
pp_alb_target_group = alb_target_group
pp_alb_listener = alb_listener

VPC
pp-vpc = vpc