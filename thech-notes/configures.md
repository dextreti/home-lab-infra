-- create directory 
  mkdir actions-runner && cd actions-runner
-- install unzip
  sudo apt update && sudo apt install -y unzip

-- Select options
  Github->setting->actions->Runners->button create runners : follow steps exec commands
  this service will be bridge between my pc and github

init a few questions:

Enter the name of the runner group: Press Enter (Default).
Enter the name of runner: Type debian-geekom (or just press Enter to use the hostname).
Enter labels: Type on-premise, debian (These tags help us target this specific computer later in the code).
Enter name of work folder: Press Enter (Default: _work).

-- After exex all command of the github follow
  sudo ./svc.sh install
  sudo ./svc.sh start

-- GitHub Settings -> Actions -> Runners
-- from here we can add new labels


- Option: Settings->Actions->Secrets and variables->Actions
 click : New repository secret


estructure folders

 home-lab-infra/
├── .github/workflows/
│   └── terraform.yaml      # The "Brain" (Automation)
├── terraform/              # The "Foundation" (Server/K3s)
│   ├── main.tf
│   └── variables.tf
└── k3s/                              # The "House" (Your Apps)
    ├── northwind.sql                 # The Data
    ├── postgres-pod.yaml             # The Database Deployment
    └── postgres-init-config.yaml     # The ConfigMap for initialization